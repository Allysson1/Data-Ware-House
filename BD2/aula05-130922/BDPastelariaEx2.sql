create database Pastelaria
go


use Pastelaria
go


create table Produtos
(CodigoProduto int primary key identity(1,1) not null,
Descricao varchar(80)not null,
DataCadastro datetime default getdate(),
ValorUnitario float not null,
CodigoFornecedor int not null)
go


Create table Pedidos 
(CodPedido int not null primary key identity(1,1),
CodigoProduto int not null,
CodigoCliente int not null,
Valor decimal(10,2) not null)
go



Create table Estoque
(CodigoEstoque int not null primary key identity(1,1), --incluir a chave estrangeira do livro como chave primaria no estoque
CodigoProduto int not null,
QuantidadeProduto int not null)
go


create table Clientes
(CodigoCliente int not null primary key identity(1,1),
CPFCliente bigint not null unique,
NomeCliente varchar(100))
go


create table Fornecedores
(CodigoFornecedor int primary key identity(1,1)  not null,
RazaoSocial varchar(80) not null,
Apelido varchar(30) null,
CNPJ bigint not null,
CPF bigint not null,
dataCadastro datetime default getdate(),
Email varchar(100) not null)
go  



--inserindo os valores na tabela fornecedores

insert into Produtos(Descricao, ValorUnitario, CodigoFornecedor, DataCadastro)
values ('Agua Sanitária',  6.99, 1, '01-12-2018'),
	   ('Arroz',  16.99, 2, '01-11-2018'),
	   ('Leite Condensado', 5.99, 3,'05-11-2018'),
	   ('Feijão',  8.99, 4,  '30-11-2018'),
	   ('Coca-Cola pet 2l',  7.99, 5, '01-12-2020'),
	   ('Dolly Guaraná pet 2l', 4.99, 6, '01-12-2019'),
	   ('Desinfetante',  6.99, 7, '01-12-2017'),
	   ('Alvejante',  8.99, 8, '01-01-2015'),
	   ('Refrigerante Abacaxi 2l', 4.69, 9, '01-02-2020'),
	   ('Pão Conjelado', 56.99, 10, '01-12-2009')
go




insert into Pedidos (CodigoCliente, CodigoProduto, Valor)
values (10,1, 10.99),
	   (9,2, 134.99),
	   (8,3, 290.00),
	   (7,4, 4358.00),
	   (6,5, 3534.33),
	   (5,6, 2354.33),
	   (4,7, 235.90),
	   (3,8, 235.97),
	   (2,9, 345.09),
	   (1,10, 2354.91)
go


insert into Estoque (CodigoProduto, QuantidadeProduto)
values (1, 31),
	   (2, 34),
	   (3, 35),
	   (4, 45),
	   (5, 5),
	   (6, 5),
	   (7, 875),
	   (8, 985),
	   (9, 243),
	   (10, 234)
go



insert into Clientes (NomeCliente, CPFCliente)
values ('Allysson', 10989498900 ),
		('João', 1284798980),
		('Marcus', 344900),
		('Bill', 5049800),
		('Luan', 2049889400),
		('Maria', 144480),
		('Marcia', 3400),
		('Cirilo', 1486777944),
		('Daniel', 1486775554),
		('PAul', 1486774544)
go






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
	   ('Jundia', 'Sorvete', 98765633, 78546734, 'jundia@gmail.com')
go




--relacionamentos

alter table Produtos 
add constraint FK_Produtos_Fornecedores foreign key (CodigoFornecedor)
references Fornecedores(CodigoFornecedor)
go


alter table Pedidos 
add constraint FK_Produto_CodProduto foreign key (CodigoProduto)
references Produtos(CodigoProduto)
go


alter table Pedidos 
add constraint FK_Produto_CodCliente foreign key (CodigoCliente)
references Clientes(CodigoCliente)
go


alter table Estoque
add constraint FK_Produto_CodProduto_Estoque foreign key (CodigoProduto)
references Produtos(CodigoProduto)
go



--3 Na tabela de Produtos deverá ser adicionada uma nova coluna com o nome de DataValidade.

alter table Produtos
add DataValidade date
go



--5. Atualizar os Pedidos de número: 1, 3, 5, 7 e 9, mudando o valor do campo Total para R$ 100,00.
update Pedidos 
set Valor = 100.00
where CodPedido in (1,3,5,7,9)
go

select * from Pedidos


--6. Na Tabela de Fornecedores, exclua os fornecedores 2,4,6 e 8.
--Neste caso é necessário apagar antes na tabela Produtos que recebe a foreign key de Fornecedores, pois se não feito isso ocorrerá conflito. Faça o teste para ver o erro que aparece

select * From Produtos

delete from Estoque
where CodigoProduto in (2,4,6,8)
go

--erro --utilizar o delete e update cascade no relacionamento
delete from Produtos
where CodigoProduto in (2,4,6,8)
go


--erro
delete from Fornecedores
where CodigoFornecedor in (2,4,6,8)
go





--7. Na Tabela Clientes crie uma Constraint do Tipo Default para a coluna DatadeCadastro.

alter table Clientes 
add DataDeCadastro date default getdate()
go


--8. Deverá ser criada uma Tabela que apresente os dados tabelas de Produtos e Fornecedores.


select forn.Apelido, forn.CNPJ, forn.CodigoFornecedor, forn.CPF, forn.dataCadastro,forn.Email, forn.RazaoSocial,
Prod.CodigoProduto, Prod.Descricao, Prod.ValorUnitario
into Produtos_Fornecedores From Fornecedores forn inner join Produtos Prod
on forn.CodigoFornecedor = Prod.CodigoProduto
go


select * from Produtos_Fornecedores
