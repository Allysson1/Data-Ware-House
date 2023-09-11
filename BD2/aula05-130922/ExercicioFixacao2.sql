create database FATECBD2AllyssonEx1
go

use FATECBD2AllyssonEx1
go


create table Livros
(CodigoLivro int not null primary key identity(1,1),
CodigoAutor int not null,
CodigoEditora int not null,
EdicaoLivro int not null,
NomeLivro varchar(80) not null,
Idioma varchar(30) not null,
AnoLancamento int not null,
ISBN varchar(20) not null, 
Preco decimal(10,2) not null,
NumeroPaginas int not null)
go


create table Autores
(CodigoAutor int not null primary key identity(1,1),
NomeAutor varchar(40) not null,
PaisNascimento varchar(40) not  null,
DataNascimentoAutor Date null,
Biografia varchar(200) not null)
go


create table Editoras
(CodigoEditora int not null primary key identity(1,1), --definindo chave primaria
NomeEditora varchar(30) not null,
Endereco varchar(80) not null,
telefone bigint not null)
go


Create table Estoque
(CodigoEstoque int not null primary key identity(1,1), --incluir a chave estrangeira do livro como chave primaria no estoque
CodigoLivro int not null,
QuantidadeLivro int not null)
go



create table Clientes
(CodigoCliente int not null primary key identity(1,1),
CPFCliente bigint not null unique,
NomeCliente varchar(100))
go

create table Venda
(CodigoVenda int not null primary key identity(1,1),
CodigoLivro int not null,
CodigoCliente int not null, 
DataVenda datetime default getdate())
go



--Insira 8 linhas de registro em cada tabela, evitando repetir valores em suas colunas;



insert into Autores (NomeAutor, PaisNascimento, DataNascimentoAutor, Biografia)
values ('Jose', 'Brasil', '08-09-1992', 'Adoro comer pão'),
	   ('Jorge Washinton', 'EUA', '08-09-1892', 'Há uma capital com o seu nome'),
	   ('David', 'Canada', '08-09-1982', 'Adora signos'),
	   ('Miranda', 'Angola', '08-09-1962', 'Gsota de colecionar pedras'),
	   ('BILL', 'Brasil', '08-09-1987', 'BORA BILL'),
	   ('Jose', 'Brasil', '08-10-1992', '...'),
	   ('Angelo', 'Alemanha', '10-11-1992', 'Adora arvores'),
	   ('Mikelangelo', 'Portugal', '04-09-1992', 'Isto estas muito fixe')
go


insert into Clientes (NomeCliente, CPFCliente)

values ('Allysson', 10989498900 ),
		('João', 1284798980),
		('Marcus', 344900),
		('Bill', 5049800),
		('Luan', 2049889400),
		('Maria', 144480),
		('Marcia', 3400),
		('Cirilo', 1486777944)
go



insert into Estoque (CodigoLivro, QuantidadeLivro)
values (1, 31),
	   (2, 34),
	   (3, 35),
	   (4, 45),
	   (5, 5),
	   (6, 5),
	   (7, 875),
	   (8, 985)
go


insert into Editoras (NomeEditora, Endereco, telefone)
values ('Blue', 'Rua Joaquin', 1234897543),
	   ('red', 'Rua João', 1234884843),
	   ('pink', 'Rua Enrrique', 1234896453),
	   ('yellow', 'Rua Eucrides', 1234897533),
	   ('Black', 'Rua Don Juan', 1234897544),
	   ('Gray', 'Rua Januario', 1234897555),
	   ('White', 'Rua Alemão', 1234647543),
	   ('Purple', 'Rua Antonio', 1584897543)
go



insert into Venda (CodigoLivro, CodigoCliente)
values (1,8),
	   (6,4),
	   (4,3),
	   (5,2),
	   (2,1),
	   (3,5),
	   (8,6),
	   (7,5)
go


insert into Livros (EdicaoLivro, NomeLivro, Idioma, AnoLancamento, ISBN, Preco, NumeroPaginas, CodigoAutor, CodigoEditora)
values (1, 'Harry Potter', 'Portugues-br', 2001, 54898458409, 123.00, 340, 1 , 3),
	   (3, 'Diario de Um Banana', 'Portugues-br', 2011, 548887484509, 153.00, 440, 5, 8),
	   (2, 'Jogador N°1', 'Portugues-br', 2004, 54748884509, 130.00, 160, 2, 6),
	   (1, 'Clean Code', 'Inglês', 2010, 54893748788, 123.90, 990, 3 , 7),
	   (5, 'Divergente', 'Portugues-br', 2010, 548937484778, 123.50, 340, 4, 4),
	   (7, 'Maze Runner', 'Portugues-br', 2009, 5489378884509, 123.89, 340, 6, 1),
	   (8, 'Scrum', 'Portugues-br', 2000, 54898787809, 123.00, 350, 8, 2),
	   (1, '50 tons de Preto', 'Portugues-br', 2014, 548937484509, 253.65, 366, 7, 5)
go



--Estabeleça o(s) possível(is) relacionamento(s) e defina um nome para o relacionamento.

alter table Livros 
add constraint FK_Autores_CodigoAutor foreign key (CodigoAutor)
references Autores(CodigoAutor)
go


alter table Livros 
add constraint FK_Editoras_CodigoEditora foreign key (CodigoEditora)
references Editoras(CodigoEditora)
go


alter table Estoque 
add constraint FK_Livro_CodigoLivro foreign key (CodigoLivro)
references Livros(CodigoLivro)
go


alter table Venda
add constraint FK_Livro_CodigoLivro_Venda foreign key (CodigoLivro)
references Livros(CodigoLivro)
go



alter table Venda
add constraint FK_Cliente_CodigoCliente_Venda foreign key (CodigoCliente)
references Clientes(CodigoCliente)
go


--Utilize o comando Update para alterar duas linhas de registro;
update Livros 
set NomeLivro ='Livro Caro'
where Preco > 200.00
go

select * from Clientes


--Exclua 4 linhas de registro;
delete from Estoque
where QuantidadeLivro < 30
go



--Através do comando Alter Table adicione uma nova coluna que aceite valores nulos;
alter table Livros
add Genero varchar(30) null
go


--Remova todos os dados de uma tabela sem utilizar o comando Delete;
truncate table Clientes
go


--Após excluir estes dados, remova fisicamente a tabela
drop table Clientes
go




