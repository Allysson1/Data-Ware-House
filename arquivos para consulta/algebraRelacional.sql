create database AlgebraRelacional
go


use AlgebraRelacional
go


--Criando a TAbela cargos
Create table Cargos
(CodigoCargo char(2) primary key not null,
DescricaoCargo varchar(50) not null,
VlrSalario numeric(6,2) not null)
go

--ctrl R retira o validador de c�digos da parte inferior
--criando a TAbela Departamentos
create table Departamentos 
(CodigoDepartamento char(2) primary key not null,
DescricaoDepartamento varchar(30) not null,
RamalTel smallint not null)
go


--criando a TAbela Funcionarios
create table Funcionarios
(NumeroRegistro int primary key not null,
NomeFuncionario varchar(80) not null,
DtAdmissao date default getdate(),
Sexo char(1) not null default 'M',
CodigoCargo char(2) not null,
CodigoDepartamento char(2) not null)
go


--criando os relacionamentos
alter table Funcionarios
add constraint FK_Funcionarios_Cargos foreign key (CodigoCargo)
references Cargos(CodigoCargo)
go


alter table Funcionarios
add constraint FK_Funcionarios_Departamentos foreign key (CodigoDepartamento)
references Departamentos(CodigoDepartamento)
go


--inserindo dados
insert into Cargos (CodigoCargo, DescricaoCargo, VlrSalario)
values ('C1','Aux.Vendas', 350.00),
	   ('C2','Vigia', 400.00),
	   ('C3','Vendedor', 800.00),
	   ('C4','Aux.Cobran�a', 250.00),
	   ('C5','Gerente', 1000.00),
	   ('C6','Diretor', 2500.00),
	   ('C7','Presidente', 2500.00)
go



insert into Departamentos (CodigoDepartamento, DescricaoDepartamento, RamalTel)
values ('D1', 'Assit.T�cnica',2246),
	   ('D2', 'Estoque',2589),
	   ('D3', 'Administra��o',2772),
	   ('D4', 'Seguran�a',1810),
	   ('D5', 'Vendas',2599),
	   ('D6', 'Cobran�a',2688)
go


insert into Funcionarios (NumeroRegistro, NomeFuncionario, DtAdmissao, Sexo, CodigoCargo, CodigoDepartamento)
values (101, 'Luis Sampaio', '2003-08-10','M', 'C3', 'D5'),
	   (104, 'Carlos Pereira', '2004-03-02','M', 'C4', 'D6'),
	   (134, 'Jose Alves', '2002-05-03','M', 'C5', 'D1'),
	   (121, 'Luis Paulo Souza', '2001-12-10','M', 'C3', 'D5'),
	   (195, 'Marta Silveira', '2002-01-05','F', 'C1', 'D5'),
	   (139, 'Ana Luiza', '2003-01-12','F', 'C4', 'D6'),
	   (123, 'Pedro Sergio', '2003-06-29','M', 'C7', 'D3'),
	   (148, 'Larissa Silva', '2002-06-01','F', 'C4', 'D6'),
	   (115, 'Roberto Fernandes', '2003-10-15','M', 'C3', 'D5'),
	   (22, 'Sergio Nogueira', '2000-02-10','M', 'C2', 'D4')
go




--exemplo Operador Proje��o: Qual � o nome e a data de admiss�o dos funcin�rios?

select NomeFuncionario, DtAdmissao from Funcionarios
go



--exemplo restri��o/sele��o: quais os funcionarios de sexo Masculino?
select NumeroRegistro, NomeFuncionario, DtAdmissao, Sexo, CodigoCargo, CodigoDepartamento
from Funcionarios
where Sexo = 'M' --aplicando o filtro/predicado/condi��o
go


--Exemplo - Operadores - Proje��o e Sele��o: quais os nomes e datas de admiss�o dos funcionarios que possuem o sexo feminino?
select NomeFuncionario, DtAdmissao, CodigoCargo from Funcionarios
where sexo = 'F'
order by NomeFuncionario desc
go

--Exemplo- Operador-Produto Cartesiano-- Trazendo os dados de funcionarios x Cargos--
--Linhas de Funcionarios x Linhas De cargos--
select F.NomeFuncionario, C.DescricaoCargo
from Funcionarios F cross Join Cargos C
order by F.NomeFuncionario asc
go



--aula 18/05/2022

--exemplo - operador - Uni�o -- Combina��o de tabelas e Linhas entre selects distintos--
select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C1','C3','C5','C7')

union 

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C4','C6')
go



--exemplo operador - Uni�o - Union All
select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C1','C3','C5','C7')

union all

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C4','C6')

union all

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C1','C4','C7', 'C2')
go



--Exemplo - Operador - Interse��o -- Combina��o de tabelas e linhas entre selects distintos sem repeti��o de dados no resultado
select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C4','C6')

intersect

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C3','C6', 'C7')
go



--exemplo - Operador - Diferen�a - Linhas existentes em uma tabela que n�o existem em outra--
insert into Cargos(CodigoCargo, DescricaoCargo, VlrSalario)
values ('C8', 'Aux.Vendas II', 550.00)
go


--O que Existe em Cargos e Existe em Funcion�rios --
select F.NumeroRegistro, F.NomeFuncionario, F.DtAdmissao, F.Sexo, F.CodigoCargo, F.CodigoDepartamento
from Funcionarios F
where Exists (select CodigoCargo from Cargos) -- o que existe em funcionarios deve existir na tabela cargos. atrav�s deste comando 'exists' se obtem esse comando
order by F.CodigoCargo
go



--O que est� em Cargos e Est� em funcionarios
select F.NumeroRegistro, F.NomeFuncionario, F.DtAdmissao, F.Sexo, F.CodigoCargo, F.CodigoDepartamento
from Funcionarios F
where F.CodigoCargo in (select CodigoCargo from Cargos)
order by F.CodigoCargo
go


--diferen�a entre cargos e funcion�rios - O que existe em Cargos que n�o existe em funcionarios
Select CodigoCargo from Cargos
where CodigoCargo not in (select CodigoCargo from Funcionarios)
go



--Exemplo - operador - Jun��o - Combina��o de lInhas e Colunas entre tabelas que possuem algum tipo de v�nculo relacional--
select F.NumeroRegistro, F.NomeFuncionario, C.CodigoCargo, C.DescricaoCargo, C.VlrSalario, F.CodigoDepartamento
from Funcionarios F inner join Cargos C
			on F.CodigoCargo = C.CodigoCargo --aqui encontra-se o predicado (Condi��o)
order by F.NomeFuncionario, F.CodigoCargo asc
go


--Exemplo - Operadoe - Divs�o - Rela��o completa de todos os dados da  tabela declarada a Esquerda em rela��o aos Dados Declarados da Tabela a Direita
create table Projetos
(CodigoProjeto char(8) primary key not null,
DescricaoProduto varchar(50) not null)
go



create table Equipes 
(Codigo int primary key identity(1,1) not null,
NumeroRegistroFuncionario int not null,
CodigoProjeto char(8) not null)
go


--Criando os Relacionamentos--
alter table Equipes
add Constraint Fk_Equipe_Funcionarios foreign key (NumeroRegistroFuncionario)
References Funcionarios(NumeroRegistro)
go


alter table Equipes
add Constraint Fk_Equipe_Projetos foreign key (CodigoProjeto)
References Projetos(CodigoProjeto)
go


--inserindo dados
insert into Projetos(CodigoProjeto, DescricaoProduto)
values ('Projeto1', 'Suporte'), ('Projeto2', 'Manuten��o'), ('Projeto3', 'Desenvolvimento')
go


insert into Equipes(NumeroRegistroFuncionario, CodigoProjeto)
values ('101', 'Projeto1'), ('104', 'Projeto1'), ('134', 'Projeto1'),
	   ('101', 'Projeto2'), ('104', 'Projeto2'), ('101', 'Projeto3')
go


--estabelecendo a Divis�o--
select Eq.NumeroRegistroFuncionario, F.NomeFuncionario,
	   Eq.CodigoProjeto,
	   Pr.DescricaoProduto
from Equipes Eq inner join Projetos Pr
					on Eq.CodigoProjeto = Pr.CodigoProjeto
					inner join Funcionarios F
					on F.NumeroRegistro = Eq.NumeroRegistroFuncionario
where Eq.CodigoProjeto = 'Projeto1' --outra forma de chamar � pelo c�digo do Funcionario "Where Eq.NumeroRegistroFuncionario = 101"
or Eq.CodigoProjeto = 'Projeto2'
and Eq.CodigoProjeto = 'Projeto3'
go


--Exemplo - operador - Renomea��o--
select REPLACE('Predoooo', 'o', 'i')
go


select 1 As 'Numero'
go

--forma de replace na tabela
update Funcionarios
set NomeFuncionario = REPLACE('Sampaio','m','n')
where NumeroRegistro= 101
go

--Exemplo - Operador de atribui��o --
declare @valor int 

set @valor = 1 -- Atribui��o de valor para a vari�vel

select @valor = 2 -- atribui��o--

set @valor = @valor+1 -- atribui��o--
go