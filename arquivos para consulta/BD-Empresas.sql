--continuaçã banco de dados Empresas--
use Empresas
go

--criando a Tabela Funcionarios--
create table Funcionarios
(CodigoFuncionario int not null primary key,
NomeFuncionario varchar(60) not null,
DataNascimentoFuncionario date not null,
EmailFuncionario varchar(200) not null)
go 


--alterar a tabela Funcionarios Adicionando a coluna GeneroFuncionario --
Alter table Funcionarios
add GeneroFuncionario char(1) null
go


--consultando a estrutura das tabelas
select CodigoFuncionario, NomeFuncionario, GeneroFuncionario, DataNascimentoFuncionario
from Funcionarios


--alerando a  tabela funcionarios removendo a coluna Email--
alter table Funcionarios
Drop column EmailFuncionario
go


insert into Funcionarios (CodigoFuncionario, NomeFuncionario, GeneroFuncionario, DataNascimentoFuncionario)
values (1, 'Pedro', 'M', '28-04-1980'), (2, 'Fernandas', 'F', '28-01-1981'), (3, 'Eduardo', 'M', '06-09-2001'), (4, 'joão', 'M', '28-09-2004'), (5, 'Maria Luiza', 'f', '27-02-2012') 
go


--consultando os dados cadstrados na tabela de funcionarios--
select CodigoFuncionario As 'Codigo', NomeFuncionario as 'Nome do Fucionario',
GeneroFuncionario as 'Genero', DataNascimentoFuncionario
from Funcionarios
order by DataNascimentoFuncionario desc --Definindo a ordenação em tela de forma decrescente
go


--utilizando operador lógico condicional Case, aplicado na coluna GeneroFuncionario--
select CodigoFuncionario, NomeFuncionario,
case GeneroFuncionario --inicio da case--
when 'M' then 'Masculino'
when 'F' then 'Feminino'
when 'i' then 'indefinido'
End as 'Gênero', --final case--
DataNascimentoFuncionario
from Funcionarios
order by NomeFuncionario asc
go

--filtrando os registros através do operador lógico condicional (in) conhecido como (OR)
select CodigoFuncionario, NomeFuncionario, DataNascimentoFuncionario
from Funcionarios
where CodigoFuncionario in(2,4)
go

--filtrando os registros através do operador lógico condicional (not in) conhecido como (OR)
select CodigoFuncionario, NomeFuncionario, DataNascimentoFuncionario
from Funcionarios
where CodigoFuncionario not in (2,4,5) --filtro--
go


--filtrando os registros através do operador lógico condicional AND--
select CodigoFuncionario, NomeFuncionario, DataNascimentoFuncionario
from Funcionarios
where CodigoFuncionario = 1 and GeneroFuncionario ='M' --filtro--
go


--filtrando os registros através do operador lógico condicional OR--
select CodigoFuncionario, NomeFuncionario, DataNascimentoFuncionario
from Funcionarios
where CodigoFuncionario = 2 or GeneroFuncionario ='M' --filtro--
go

