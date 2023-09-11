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

--ctrl R retira o validador de códigos da parte inferior
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
	   ('C4','Aux.Cobrança', 250.00),
	   ('C5','Gerente', 1000.00),
	   ('C6','Diretor', 2500.00),
	   ('C7','Presidente', 2500.00)
go



insert into Departamentos (CodigoDepartamento, DescricaoDepartamento, RamalTel)
values ('D1', 'Assit.Técnica',2246),
	   ('D2', 'Estoque',2589),
	   ('D3', 'Administração',2772),
	   ('D4', 'Segurança',1810),
	   ('D5', 'Vendas',2599),
	   ('D6', 'Cobrança',2688)
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




--exemplo Operador Projeção: Qual é o nome e a data de admissão dos funcinários?

select NomeFuncionario, DtAdmissao from Funcionarios
go



--exemplo restrição/seleção: quais os funcionarios de sexo Masculino?
select NumeroRegistro, NomeFuncionario, DtAdmissao, Sexo, CodigoCargo, CodigoDepartamento
from Funcionarios
where Sexo = 'M' --aplicando o filtro/predicado/condição
go


--Exemplo - Operadores - Projeção e Seleção: quais os nomes e datas de admissão dos funcionarios que possuem o sexo feminino?
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

--exemplo - operador - União -- Combinação de tabelas e Linhas entre selects distintos--
select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C1','C3','C5','C7')

union 

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C4','C6')
go



--exemplo operador - União - Union All
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



--Exemplo - Operador - Interseção -- Combinação de tabelas e linhas entre selects distintos sem repetição de dados no resultado
select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C4','C6')

intersect

select CodigoCargo, DescricaoCargo, VlrSalario
from Cargos
where CodigoCargo in ('C2','C3','C6', 'C7')
go



--exemplo - Operador - Diferença - Linhas existentes em uma tabela que não existem em outra--
insert into Cargos(CodigoCargo, DescricaoCargo, VlrSalario)
values ('C8', 'Aux.Vendas II', 550.00)
go


--O que Existe em Cargos e Existe em Funcionários --
select F.NumeroRegistro, F.NomeFuncionario, F.DtAdmissao, F.Sexo, F.CodigoCargo, F.CodigoDepartamento
from Funcionarios F
where Exists (select CodigoCargo from Cargos) -- o que existe em funcionarios deve existir na tabela cargos. através deste comando 'exists' se obtem esse comando
order by F.CodigoCargo
go



--O que está em Cargos e Está em funcionarios
select F.NumeroRegistro, F.NomeFuncionario, F.DtAdmissao, F.Sexo, F.CodigoCargo, F.CodigoDepartamento
from Funcionarios F
where F.CodigoCargo in (select CodigoCargo from Cargos)
order by F.CodigoCargo
go


--diferença entre cargos e funcionários - O que existe em Cargos que não existe em funcionarios
Select CodigoCargo from Cargos
where CodigoCargo not in (select CodigoCargo from Funcionarios)
go



--Exemplo - operador - Junção - Combinação de lInhas e Colunas entre tabelas que possuem algum tipo de vínculo relacional--
select F.NumeroRegistro, F.NomeFuncionario, C.CodigoCargo, C.DescricaoCargo, C.VlrSalario, F.CodigoDepartamento
from Funcionarios F inner join Cargos C
			on F.CodigoCargo = C.CodigoCargo --aqui encontra-se o predicado (Condição)
order by F.NomeFuncionario, F.CodigoCargo asc
go


--Exemplo - Operadoe - Divsão - Relação completa de todos os dados da  tabela declarada a Esquerda em relação aos Dados Declarados da Tabela a Direita
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
values ('Projeto1', 'Suporte'), ('Projeto2', 'Manutenção'), ('Projeto3', 'Desenvolvimento')
go


insert into Equipes(NumeroRegistroFuncionario, CodigoProjeto)
values ('101', 'Projeto1'), ('104', 'Projeto1'), ('134', 'Projeto1'),
	   ('101', 'Projeto2'), ('104', 'Projeto2'), ('101', 'Projeto3')
go


--estabelecendo a Divisão--
select Eq.NumeroRegistroFuncionario, F.NomeFuncionario,
	   Eq.CodigoProjeto,
	   Pr.DescricaoProduto
from Equipes Eq inner join Projetos Pr
					on Eq.CodigoProjeto = Pr.CodigoProjeto
					inner join Funcionarios F
					on F.NumeroRegistro = Eq.NumeroRegistroFuncionario
where Eq.CodigoProjeto = 'Projeto1' --outra forma de chamar é pelo código do Funcionario "Where Eq.NumeroRegistroFuncionario = 101"
or Eq.CodigoProjeto = 'Projeto2'
and Eq.CodigoProjeto = 'Projeto3'
go


--Exemplo - operador - Renomeação--
select REPLACE('Predoooo', 'o', 'i')
go


select 1 As 'Numero'
go

--forma de replace na tabela
update Funcionarios
set NomeFuncionario = REPLACE('Sampaio','m','n')
where NumeroRegistro= 101
go

--Exemplo - Operador de atribuição --
declare @valor int 

set @valor = 1 -- Atribuição de valor para a variável

select @valor = 2 -- atribuição--

set @valor = @valor+1 -- atribuição--
go