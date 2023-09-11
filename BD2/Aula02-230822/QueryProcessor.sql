--criando o Banco de Dados OperadoresApply--

create database OperadoresApply
go

--Criando a tabela de Clientes--
create table Clientes
(CodigoCliente int Identity(1,1) primary key not null,
NomeCliente Varchar(100) not null)
go


--criando a tabela de Orcamento
Create Table Orcamento 
(CodigoOrcamento int identity(1,1) Primary key not null,
CodigoCliente int not null,
Valor Decimal(10,2) not null,
Valor2 As (Valor/2) Persisted, --Utilizando o PErsisted, o valor não precisa ser recalculado para ser colocado na memória, logo ao ser inserido o valor já direcionado 'permanentemente' na memoria, O espaço geral do BD fica maior, mas a consulta fica mais rápida. pesquisar mais sobre-- 
Valor3 As (Valor/3) Persisted, -- sem o persisted o valor só é mostrado, com ele o valor é armazenado
Valor4 As (Valor/4) Persisted)
go


--Inserindo dados de clientes--
insert into Clientes 
(NomeCliente) values('Pedro'), ('Antonio'), ('Galvão'), ('Junior'), ('Fernanda')
go

--Inserindo dados de Orcamentos--

insert into Orcamento
(CodigoCliente, Valor) Values (1,300), (1,400), (3,100), (4,200), (1,1000), (1,700), (3,300), (3,500), (4,700), (4,5000)
go


--consultando--
select CodigoCliente, NomeCliente from Clientes
go

select CodigoOrcamento, CodigoCliente, Valor, Valor2, Valor3, Valor4 from Orcamento
go

--Exemplo 1 - Listar todos os Clientes que tem Orçamento e seus Respectivos Valores--
Select Cli.CodigoCliente, Cli.NomeCliente, Orca.Valor
from Clientes Cli Inner Join Orcamento Orca
		on	Cli.CodigoCliente = Orca.CodigoCliente 
go


--Cross APPLY--Recomendado ser usado em tabelas que tem milhares de dados-- MAis rápido que o inner join
--SubQuery = Um select dentro de outro select, sendo o Segundo select chamado de 'R' que acaba se tornando um objeto (POO)
Select * from Clientes Cli --este é o select de apresentação
Cross Apply (Select CodigoCliente, Valor, Valor2, Valor3, Valor4 from  Orcamento O --este select joga as informações para o primeiro select
		where cli.CodigoCliente = O.CodigoCliente) As R

		go



--Exemplo 2 Listar os dois maiores valores de Orçamento de cada cliente--
select C.NomeCliente, R.CodigoOrcamento, R.ValorOrcamento
From Clientes C
cross Apply (Select top 2 CodigoOrcamento , Valor --semelhante com o inner join
from Orcamento O
where C.CodigoCliente = O.CodigoCliente
order By Valor Desc) As R(CodigoOrcamento, ValorOrcamento)
go




--Exemplo 3 Listar Todos os Clientes que possuem ou não orçamento em conjunto com a soma dps valores--
select C.NomeCliente, isNull(R.CodigoOrcamento,0) As CodigoOrcamento,
					isNull(R.SomaTotalOrcamento,0) as SomaTotalOrcamento --semelhante ao left ou right join
from Clientes C
outer Apply (Select CodigoOrcamento , Valor+Valor2+Valor3+Valor4 as Soma From Orcamento O
		where C.CodigoCliente = O.CodigoCliente)
		As R (CodigoOrcamento, SomatotalOrcamento)
go