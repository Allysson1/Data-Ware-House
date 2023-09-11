--	Cross Join = produto cartesiano,é a única junção que não usa condição--

create database JuncaoCruzada
go

--acessando--
Use JuncaoCruzada
go

--exemplos de Junção Cruzada sem Tabelas - Aplicando a Junção diretamente no select --
select Alfabeto.letras, N.Numeros
from (
	values ('A'),('B'),('C'),('D'),('E')
	) as Alfabeto(letras)
	cross join (Select Numeros
		from 
		(Values(1),(2),(3)) 
		as Numeracao (Numeros)) as N
go



--criando a tabela LetrasDoAlfabeto--
create table LetrasDoAlfabeto
(Codigo tinyint primary key identity(1,1) not null, 
Descricao char(1) not null Default 'A')
go


--criando a Tabela Numeracao--
Create table Numeracao 
(CodigoNumeracao smallint primary key identity (1,1) not null)
go


--inserindo a massa de dados na tabela LetrasDoAlfabeto --faixa de valores caracteres (A e Z)--

declare @contador tinyint = 65

while @contador <=90
begin

insert into LetrasDoAlfabeto(Descricao)
values (char(@contador))

set @contador += 1 --Operador composto de incremento--
end
go

truncate table LetrasDoAlfabeto
go



--inserindo a massa de dados na tabela Numeracao --Passando o direcionamento de valores padroes--
insert into Numeracao default values 
go 9999


--consultando --
select Codigo, Descricao from LetrasDoAlfabeto
go


select * from  Numeracao
go


--realizando a junção cruzada -- utilizando o operador cross join--
select L.Descricao , N.CodigoNumeracao
from LetrasDoAlfabeto L cross join Numeracao N
where L.Descricao in ('A','C','F','X')
and N.CodigoNumeracao in (2,4)
go


--concatenando--
select L.Descricao , N.CodigoNumeracao, CONCAT(L.Descricao, N.CodigoNumeracao) as Concatenacao
from LetrasDoAlfabeto L cross join Numeracao N
where L.Descricao in ('A','C','F','X')
and N.CodigoNumeracao in (2,4)
go


--gerando todas as combinações de placas de carro entre a faixa de valores AAA-9998 até ZZZ-9998--

select L1.Descricao, L2.Descricao, L3.Descricao, N.CodigoNumeracao
from LetrasDoAlfabeto L1 
cross join LetrasDoAlfabeto L2
cross join LetrasDoAlfabeto L3
cross join Numeracao N
--where Descricao in ('A','B')
go