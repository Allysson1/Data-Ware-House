create database RestricoesDeIntegridade--
go

use RestricoesDeIntegridade
go

--criando a tabela Funcionarios utilizando Constraints - not null, null, check, default e Unique --
create table Funcionarios
(Codigo int primary key identity(1,1),
Nome varchar(80) not null,
Sexo char(1) check (sexo ='F' or sexo = 'M'),
RG int not null Unique,
CPF int not null Unique,
DataNascimento date check (DataNascimento>='1950-01-01'),
DataCadastro DateTime default GetDate(),
Email varchar(100) null)
go


--criando a Tabela Clientes utilizando constraints - not null, null, check, default e Unique--
create table Clientes
(Codigo int identity (1,1),
Nome varchar(80) Not null,
Sexo char(1),
RG int not null,
CPF int not null,
DataNascimento Date,
DataCadastro DateTime constraint DF_Clientes_DataCadastro default getdate(),
Email varchar(100) null,
Constraint PK_Clientes_Codigo primary key (codigo),
Constraint CK_Clientes_Sexo check (sexo ='F' or sexo = 'M'),
Constraint UQ_Clientes_RG Unique NonClustered(RG),
Constraint UQ_Clientes_CPF Unique NonClustered(CPF),
Constraint CK_Clientes_DataNascimento check (DataNascimento>='1950-01-01'))
go



--adicionando uma nova constraint default--
alter table Clientes add Constraint DF_Clientes_Sexo default 'M' for sexo
go


--Removendo uma constraint já existente--
alter table Clientes drop Constraint CK_Clientes_DataNascimento
go


--adicionando uma nova Constraint de Validção (Check)--
alter table Clientes Add Constraint CK_Clientes_DataNascimento check (DataNascimento>='1978-01-01')
go


--remove fisicamente a tabela--
drop table Clientes
go


--alter a tabela funcionarios e a coluna Email--
alter table Funcionarios
alter column Email varchar(200) not null
go


alter table Funcionarios 
Drop column Email
go



--Criando a tabela pessoas--
Create table Pessoas
(Codigo int identity(1,4),
Nome varchar (80) not null,
Sexo char(1) default 'M',
DataCadastro Date Constraint DF_Clientes_DT default getdate()+1,
Salario Money not null,
Constraint PK_Pessoas_Codigo primary key (codigo))
go


--inserindo uma nova massa de dados na tabela PEssoas--  rand() são valores randomicos 'vezes' 1000
insert into Pessoas(Nome, Salario)
values (concat('Pessoas número:',ident_current('Pessoas')),rand()*1000)
go 1000


--consultando os dados da tabela Pessoas--
select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas
order by Salario desc
go