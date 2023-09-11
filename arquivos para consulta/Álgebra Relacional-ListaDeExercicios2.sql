-- Códigos pegos do Arquivo PDF Banco de Dados I-aula 16-Lista de Execícios 2 - Versão 1.pdf
create database AlgebraRelacional
go

-- Acessando o Banco de Dados - AlgebraRelacional --
Use AlgebraRelacional
Go
-- Criando a Tabela Funcao --
Create Table Funcao
(CodigoFuncao Char(3) Primary Key Not Null,
 DescricaoFuncao Varchar(50) Not Null,
 ValorSalario Numeric(6,2) Not Null)
Go
-- Criando a Tabela Areas --
Create Table Areas
(CodigoArea Char(2) Primary Key Not Null,
DescricaoArea Varchar(30) Not Null,
RamalTelefone SmallInt Not Null)
Go
-- Criando a Tabela Funcionarios --
Create Table Funcionarios 
(NumeroRegistro Int Primary Key Not Null,
NomeFuncionario Varchar(80) Not Null,
DtAdmissao Date Default GetDate(),
Sexo Char(1) Not Null Default'M',
CodigoFuncao Char(3) Not Null,
CodigoArea Char(2) Not Null,
CodigoDoGestor TinyInt Not Null)
Go
-- Criando os relacionamentos --
Alter Table Funcionarios
Add Constraint[FK_Funcionarios_Funcaos] Foreign Key (CodigoFuncao)
 References Funcao(CodigoFuncao)
Go
Alter Table Funcionarios
Add Constraint[FK_Funcionarios_Areas] Foreign Key (CodigoArea)
 References Areas(CodigoArea)
Go

-- Inserindo os Dados --
Insert Into Funcao (CodigoFuncao,DescricaoFuncao, ValorSalario)
Values ('F1', 'Aux.Vendas', 350.00),
('F2', 'Vigia', 400.00),
('F3', 'Vendedor', 800.00),
('F4', 'Aux.Cobrança', 250.00),
('F5', 'Gerente', 1000.00),
('F6', 'Diretor', 2500.00),
('F7', 'Diretor II', 4500.00),
('F8', 'Diretor III', 6500.00),
('F9', 'Vice-Presidente', 800.00),
('F10', 'Presidente', 9990.00)
Go
Insert Into Areas(CodigoArea,DescricaoArea,RamalTelefone)
Values ('A1', 'Assist.Técnica', 2246),
('A2', 'Estoque', 2589),
('A3', 'Administração', 2772),
('A4', 'Segurança', 1810),
('A5', 'Vendas', 2599),
('A6', 'Cobrança', 2688),
('A7', 'Tecnologia', 2110),
('A8', 'Engenharia', 3499),
('A9', 'Qualidade', 4868)
Go
Insert Into Funcionarios (NumeroRegistro,NomeFuncionario,DtAdmissao, Sexo, CodigoArea,
CodigoFuncao, CodigoDoGestor)
Values (101, 'Juca Sampaio', '2003-08-10', 'M', 'A3', 'F5',22),
 (104, 'Fernando Pereira', '2004-03-02', 'M', 'A4', 'F6',101),
 (134, 'João Alves', '2002-05-03', 'M', 'A5', 'F1',123),
 (121, 'Paulo Souza', '2001-12-10', 'M', 'A6', 'F5',115),
 (195, 'Maria Silveira', '2002-01-05', 'F','A3', 'F5',139),
 (139, 'Ana Laura', '2003-01-12', 'F', 'A4', 'F6',123),
 (123, 'Silvio Rocha', '2003-06-29', 'M', 'A6', 'F3',148)
Go
Insert Into Funcionarios (NumeroRegistro,NomeFuncionario,DtAdmissao, Sexo, CodigoArea,
CodigoFuncao, CodigoDoGestor)
Values (100, 'Rita Cadilac', '2004-11-15', 'M', 'A8', 'F10',100),
 (148, 'Iolanda Aguiar', '2002-06-01', 'F', 'A5', 'F3',195),
 (115, 'Roberto Fernandes', '2003-10-15', 'M', 'A2', 'F2',148),
 (102, 'Sergio Noriega', '2000-02-10', 'M', 'A6', 'F6',100),
 (203, 'Chico Dito', '2005-06-30', 'M', 'A5', 'F8',148),
 (204, 'Maria Bonita', '2001-06-03', 'F', 'A7', 'F9',203)
Go




--Códigos Feitos Por Állysson
--1
--a) Deseja através de um comando Select, obter: O nome, data de admissão e sexo de todos os funcionários.
select NomeFuncionario, DtAdmissao, Sexo
from Funcionarios
go

--B) Deseja através de um comando Select, obter: Quais são os funcionários de sexo feminino?
select NomeFuncionario, DtAdmissao, Sexo
from Funcionarios
where Sexo = 'F'
go

-- C) Deseja através de um comando Select, apresentar: As informações dos funcionários e de Funcao: Linhas de Funcionarios X Linhas de Funcao.
select F.NumeroRegistro, F.NomeFuncionario, F.DtAdmissao, F.Sexo, F.CodigoFuncao, F.CodigoArea, Fun.DescricaoFuncao, Fun.ValorSalario
from Funcionarios F inner join Funcao Fun
							on F.CodigoFuncao = fun.CodigoFuncao
go


--d) Deseja através de um comando Select, apresentar: A combinação de Tabelas e Linhas entre selects distintos sem repetição de dados no resultado.
select NumeroRegistro,NomeFuncionario,DtAdmissao, Sexo, CodigoArea,
CodigoFuncao, CodigoDoGestor
from Funcionarios
where CodigoFuncao in ('F1','F2','F4','F6','F7','F8','F9')
 
intersect 

select NumeroRegistro,NomeFuncionario,DtAdmissao, Sexo, CodigoArea,
CodigoFuncao, CodigoDoGestor
from Funcionarios
where CodigoFuncao in ('F2','F3','F4','F5','F10')
go


--e) Deseja através de um comando Select, obter: Todas as funções existentes na tabela Funcao que não possuam funcionários cadastrados.Select CodigoFuncao from Funcao
where CodigoFuncao not in (select CodigoFuncao from Funcionarios)
go
--F) Deseja através de um comando Select realizar um auto relacionamento na tabela Funcionarios, apresentando um resultado similar ao ilustrado na Figura 2


select F.NumeroRegistro,
F.NomeFuncionario, 
A.DescricaoArea as 'Descrição Da Área de Trabalho',
Fun.DescricaoFuncao as 'Descrição Da Função',
F.DtAdmissao,
F.CodigoDoGestor
from Funcionarios F inner join Funcao Fun
							on F.CodigoFuncao = fun.CodigoFuncao
							inner join Areas A
							on F.CodigoArea = A.CodigoArea
order by CodigoDoGestor asc
go


--modo correto de fazer
-- Realizando um AutoRelacionamento (Self Join) --
Select  F.NumeroRegistro, 
			F.NomeFuncionario, 
			A.DescricaoArea 'Descricação da Área de Trabalho',
			F1.DescricaoFuncao 'Descricação da Função',
			Year(F.DtAdmissao) As Ano,
			Month(F.DtAdmissao) As Mês,
			Day(F.DtAdmissao) as Dia,
			Convert(Varchar(3),F.CodigoDoGestor) + ' - ' + F2.NomeFuncionario As 'Gestor ou Responsável'
From Funcionarios F Inner Join Areas A
								  On F.CodigoArea = A.CodigoArea
								 Inner Join Funcao F1
								  On F.CodigoFuncao = F1.CodigoFuncao
								 Inner Join Funcionarios F2
								  On F2.NumeroRegistro = F.CodigoDoGestor
Order By F.CodigoDoGestor Asc
Go