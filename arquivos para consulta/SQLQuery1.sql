
--criando a Tabela Editoras--
create table Editoras
(CodigoEditora int not null Primary key, --definindo chave primaria
NomeEditora varchar(30) not null,
DescricaoEditora varchar(20))
go

--criando a tabela autores
create table Autores
(CodigoAutor int not null Primary key,
NomeAutor varchar(40) not null,
SexoAutor char(1) null,
DAtaNascimentoAutor Date null)
go


--criando a tabela de livros--
create table Livros
(CodigoLivro int not null primary key,
CodigoEditora int not null,
CodigoAutor int not null,
NomeLivro varchar(80) not null,
DescricaoLivro varchar(60) not null,
ISBN varchar(20) not null) -- ISBM é um número internacional de identificação do livro
go


--criando a tabela clientes--
create table Clientes
(CodigoCliente int not null,
NomeCliente varchar(100))
go


--adicionando a propriedade chave primaria na tabela Clientes, definindo a coluna CodigoCliente
alter table Clientes
add constraint PK_Clientes_CodigoCliente Primary Key (CodigoCliente) --constraint(regra, imposição adiciona um nome mais fácil de entender)--
go


--inserindo dados na tabela Autores - utilizando tecnica a partir da versão 2008 do sql server
insert into Autores (CodigoAutor, NomeAutor, DAtaNascimentoAutor, SexoAutor)
values (1, 'Autor A','06-04-1980','M'),
(2,'Autor B','08-05-1980','F'),
(3,'Autor C','18-06-1980','F')
go


--Inserindo dados na Tabela Editoras - Utilizando técnica tradicional de inserção de dados--
insert into Editoras(CodigoEditora, NomeEditora, DescricaoEditora)
values(1,'Editora Azul','Blue')

insert into Editoras (CodigoEditora, NomeEditora, DescricaoEditora)
values (2,'Editora Amarela','Yellow')
go


--consultando ou consumindo os dados--
select CodigoEditora, NomeEditora, DescricaoEditora from Editoras
go

--consultando ou consumindo dados de forma ordenada
select CodigoEditora, NomeEditora, DescricaoEditora from Editoras
order by NomeEditora asc
go


--criando a tabela funcionarios--
create table Funcionarios
(CodigoFuncionario int Primary key not null,
NomeFuncionario varchar(60) not null,
DataNascimentoFuncionario date not null,
EmailFuncionario varchar(200) not null)
go


--criando tabela socios--
Create table Socios 
(CodigoSocio int,
NomeSocio Varchar(60) not null,
DataNascimento date not null,
Email varchar(200) not null)
go


--alterando a coluna CodigoSOcio para NotNull
alter table Socios
alter Column CodigoSocio int not null
go


--alterando a chave primaria na tabela SOcios definindo a coluna CodigoSocio
alter table Socios
add constraint PK_Socios_CodigoSocio primary key (CodigoSocio)
go


--criando a tabela reservas
create table Reservas 
(CodigoReserva int primary key not null,
CodigoLivro int not null,
CodigoFuncionario int not null,
CodigoSocio int not null,
DataReserva DateTime not null,
DataDevolucao dateTime not null,
StatusReserva char(1) not null) 
go


--adicionando o relacionamento entre a tabela Reservas e a tabela Livros - atraves da Coluna CodigoLivro--
alter table Reservas
add constraint FK_Reservas_Livros_CodigoLivro foreign key (CodigoLivro) --a coluna de destino que recebera 
References Livros(CodigoLivro) -- a coluna de origem que contem o valor da chave primaria na tabela de livros
go


--adicionando o relacionamento entre a tabela Reservas e a tabela Funcionarios - atraves da coluna COdigoFuncionario
alter table Reservas
add constraint FK_Reservas_Funcionarios_COdigoFuncionario foreign key (CodigoFuncionario)
references Funcionarios(CodigoFuncionario)
go


--adicionando o relacionamento entre a tabela Reservas e a Tabela Socios - Atraves da Coluna COdigoSocios
alter table Reservas
add constraint FK_Reservas_Socios_CodigoSocio foreign key (CodigoSocio)
references Socios(CodigoSocio)





