--Criando o banco de dados

create database INPC
go

use INPC
go

--criando a tabela INPCDiasDeAtraso
create table INPCDiasDeAtraso
(CodigoINPC int identity(1,1) primary key,
DataINPC as (DateAdd(Day, CodigoINPC, getdate())),
AnoINPC as (year(getdate()+CodigoINPC)),
MesINPC as (Month(getdate()+CodigoINPC)),
ValorINPC as (0.01*CodigoINPC))
go

--inserindo dados 
insert into INPCDiasDeAtraso default values
go 1000


--consultando--
select Top 100 CodigoINPC, CONVERT(date,DataINPC) as DataINPC, AnoINPC, MesINPC, ValorINPC
from INPCDiasDeAtraso
order by ValorINPC asc
go

--criando a tabela de pagamentos
create table Pagamentos 
(CodigoPagamento int identity(1,1) primary key,
DataVencimento as (DateAdd(Day,CodigoPagamento,Getdate())),
DataPagamento as (DateAdd(day, CodigoPagamento, Getdate()+CodigoPagamento)),
ValorParcela as (Rand()*CodigoPagamento+100))
go


--inserindo uma massa de dados--
insert into Pagamentos default values
go 1000

--consultando--

Select Top 200 P.CodigoPagamento, CAST(P.DataVencimento as Date) as DataVencimento,
			CAST (P.DataPagamento as date) as DataPagamento, 
			CAST (P.ValorParcela as decimal(10,2)) as ValorParcela
from Pagamentos P
order by DataVencimento desc
go



--simulando o calculo de juros com base na diferença entre a data de pagamento e data de vencimento--

Select P.CodigoPagamento,
	cast(P.DataVencimento as Date) as DataVencimento,
	Cast(P.DataPagamento as date) as DataPagamento,
	Cast(P.ValorParcela as Decimal(10,2)) as ValorParcela,
	DateDiff(Day, P.DataVencimento, P.DataPagamento) as 'Dias de Atraso',
	concat(isNull(i.ValorINPC,0),'%') as ValorINPC,
	cast(P.ValorParcela+(P.ValorParcela*i.ValorINPC) as Decimal(10,2)) as NovaParcela

from Pagamentos P outer Apply (select ValorINPC from INPCDiasDeAtraso
								where CodigoINPC = DateDiff(Day, P.DataVencimento, P.DataPagamento)) as i
where Datediff(Day, P.DataVencimento, P.DataPagamento) <= 50 --quantidade de dias
go



-- Simulando o cálculo de juros como base na diferença entre data de pagamento e data de vencimento, formatando os valores com a funçao format()

Select P.CodigoPagamento, 
	CAST (P.DataVencimento as date) as DataVencimento, -- o cast é parecido com o convert, a diferença é que no convert é possivel modificar o tipo de apresentação. EX: posso solicitar para o convert exibir a data que está em padrão americano em padrão brasileiro utilizando o código 103 ao fim do comando "Convert (P.DataVencimento as date, 103) as DataVencimento"
	CAST (P.DataPagamento as date) as DataPagamento,
	FORMAT (P.ValorParcela, 'C', 'pt-br') as 'Valor da PArcela',
	DATEDIFF (DAY, P.DataVencimento, P.DataPagamento) as 'Dias de Atraso',
	CONCAT(ISNULL(i.valorINPC, 0),'%') as ValorINPC,
	FORMAT (P.ValorParcela+(P.ValorPArcela * i.ValorINPC), 'C', 'Pt-br') as 'Novo Valor da PArcela',
	FORMAT (P.ValorParcela*(+i.ValorINPC), 'C', 'Pt-br') as '# entre o valor pago - Valor a ser pago'

from Pagamentos P outer apply(select ValorINPC from INPCDiasDeAtraso
									where CodigoINPC = DATEDIFF(DAY, P.DataVencimento, P.DataPagamento)) as i
where DATEDIFF(DAY, P.DataVencimento, P.DataPagamento) <= 200
--order by[# entre o valor pago - Valor a ser pago] desc --o colchetes [] se refere as '' do texto, melhora o processamento do order by pois caso usasse as '' ele iria converter o texto dentro dos colchetes -- este comando não é o correto a ser usado, o da linha abaixo é o certo
order by FORMAT (P.ValorParcela*(+i.ValorINPC), 'C', 'Pt-br') desc -- forma correta de usar o comando acima
go







