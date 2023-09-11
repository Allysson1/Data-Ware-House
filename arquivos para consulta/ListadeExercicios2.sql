--1 criando o bancos
create database ListaDeExercicios2
go

--2 elecionando o banco
use ListaDeExercicios2
go

--3 criando a tabela fornecedores
create table Fornecedores
(Codigo int primary key identity(1,1)  not null,
RazaoSocial varchar(80) not null,
Apelido varchar(30) null,
CNPJ bigint not null,
CPF bigint not null,
dataCadastro datetime default getdate(),
Email varchar(100) not null)
go  


--criando a tabela produtos
create table Produtos
(Codigo int primary key identity(1,1) not null,
Descricao varchar(80)not null,
DataCadastro datetime default getdate(),
Quantidade smallint not null,
ValorUnitario float not null,
CodFornecedor int not null)
go




--4 estabelecendo os relacionamentos

alter table Produtos 
add constraint FK_Produtos_Fornecedores foreign key (CodFornecedor)
references Fornecedores(Codigo)
go


--5 inserindo os valores na tabela fornecedores
insert into Fornecedores (RazaoSocial, Apelido, CNPJ, CPF, Email)
values ('Ypê', 'Limpeza', 98787933, 78008734, 'yoe@gmail.com'),
	   ('Camil', 'comida', 98787955, 78046734, 'camil@gmail.com'),
	   ('Jussara', 'leite', 94487933, 78118734, 'jussara@gmail.com'),
	   ('Sorocaba', 'feijão', 98787783, 78008444, 'sorocaba@gmail.com'),
	   ('Coca-Cola', 'Refrigerante', 11787933, 11008734, 'Coca-Cola@gmail.com'),
	   ('Dolly', 'Refrigerante2', 98444793, 78708734, 'dolly@gmail.com'),
	   ('Sanol', '', 98712121, 78012121, 'sanol@gmail.com'),
	   ('Candura', '', 98457933, 73508734, 'Candura@gmail.com'),
	   ('Rossi', 'Refrigerante3', 98787923, 78008722, 'Rossi@gmail.com'),
	   ('Marqspan', 'Pão', 98787663, 78008454, 'marqspan@gmail.com'),
	   ('Jundia', 'Sorvete', 98765633, 78546734, 'jundia@gmail.com'),
	   ('Kibon', 'Sorvete2', 98456933, 78978734, 'kibon@gmail.com'),
	   ('Nestle', '', 98787555, 78108788, 'nestle@gmail.com'),
	   ('Mondeles', '', 22787933, 22008734, 'mondeles@gmail.com'),
	   ('Parati', '', 98784443, 74448734, 'parati@gmail.com')
go


--inserindo os valores na tabela produtos
insert into Produtos(Descricao, Quantidade, ValorUnitario, CodFornecedor, DataCadastro)
values ('Agua Sanitária', 0, 6.99, 1, '01-12-2018'),
	   ('Arroz', 10, 16.99, 2, '01-11-2018'),
	   ('Leite Condensado', 60, 5.99, 3,'05-11-2018'),
	   ('Feijão', 100, 8.99, 4,  '30-11-2018'),
	   ('Coca-Cola pet 2l', 1000, 7.99, 5, '01-12-2020'),
	   ('Dolly Guaraná pet 2l', 200, 4.99, 6, '01-12-2019'),
	   ('Desinfetante', 17, 6.99, 7, '01-12-2017'),
	   ('Alvejante', 9, 8.99, 8, '01-01-2015'),
	   ('Refrigerante Abacaxi 2l', 20, 4.69, 9, '01-02-2020'),
	   ('Pão Conjelado', 2000, 56.99, 10, '01-12-2009'),
	   ('Sorvete Chocolate', 100, 26.99, 11, '01-06-2010'),
	   ('Sorvete Creme', 250, 27.99, 12, '31-10-2015'),
	   ('Bombons Sortidos', 357, 10.99, 13, '01-05-2021'),
	   ('Chocolate Bis', 190, 7.99, 14, '01-09-2015'),
	   ('Biscoito', 230, 2.99, 15, '01-10-2012')
go


-- 6 conferindo as inserções
select * from Fornecedores
go


select * from Produtos
go



-- 7 junção entre tabelas
select F.Codigo, F.RazaoSocial, F.Apelido, F.CNPJ, F.CPF, F.Email,
	   P.Descricao, P.Quantidade, P.ValorUnitario, P.CodFornecedor
from Fornecedores F inner join Produtos P
						on F.Codigo = P.CodFornecedor
go


--8 quantidade maior que 10
select F.Codigo, F.RazaoSocial, F.Apelido, F.CNPJ, F.CPF, F.Email,
	   P.Descricao, P.Quantidade, P.ValorUnitario, P.CodFornecedor
from Fornecedores F inner join Produtos P
						on F.Codigo = P.CodFornecedor
where P.Quantidade > 10
go



--9 data cadastro entre os 2018-11-01 e 2018-11-30;
select F.Codigo, F.RazaoSocial, F.Apelido, F.CNPJ, F.CPF, F.Email,
	   P.Descricao, P.Quantidade, P.ValorUnitario, P.CodFornecedor
from Fornecedores F inner join Produtos P
						on F.Codigo = P.CodFornecedor
where P.DataCadastro >= '01-11-2018' and P.DataCadastro <='30-11-2018'
go


--10 união de dados
select Descricao, Quantidade, ValorUnitario, CodFornecedor, DataCadastro
from Produtos
where Codigo in (1,2,3,6,8,10,11,13,14,15)

union

select Descricao, Quantidade, ValorUnitario, CodFornecedor, DataCadastro
from Produtos
where Codigo in (4,5,7,9,12)
go