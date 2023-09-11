create database FATECBD1AllyssonEx1
go

use FATECBD1AllyssonEx1
go


--iniciando a criação das tabelas--
create table Cliente 
(CodCliente int not null primary key identity(1,1),
CodLocacao int not null,
CpfCliente bigint not null unique, 
Telefone bigint not null unique,
NomeCliente varchar(200) not null,
Endereco varchar(200))
go


drop table Cliente
go


create table Dependente
(CodDependente int not null primary key identity(1,1),
CodCliente int not null, --está coluna se tornará uma constraint para mostrar a qual Cliente o dependente pertence--
NomeDependente varchar(200))
go



create table Ator
(CodAtor int not null primary key identity(1,1),
NomeAtor varchar(200) not null,
DataNascimento dateTime)
go



create table Filme
(CodFilme int not null primary key identity(1,1),
NomeFilme varchar(200) not null,
GeneroFilme varchar(20) not null)
go


create table Filme_Ator
(CodFilme_Ator int not null primary key identity(1,1),
CodFilme int not null,
CodAtor int not null)
go



create table Locacao
(CodLocacao int not null primary key identity(1,1),
CodFilme int not null,
CodFita int not null,
CodCliente int not null,
CodFilme_Ator int not null,
QuantidadeFilmes int not null,
DataLocacao datetime default getdate(),
DataDevolucao datetime)
go



create table Fita
(CodFita int not null primary key identity(1,1),
CodFilme int not null,
QuantidadeFitasPorFilme int not null)
go




--iniciando o registro de 8 linhas em cada tabela--

insert into Cliente(CodLocacao, CPFCliente, Telefone, NomeCliente, Endereco)  --itens não conseguem ser inseridos--
values(1, 56899993821, 11945687744, 'João', 'Rua Dos Gatos Selvagens'),
	  (2, 56898883821, 11961235744, 'Pedro', 'Rua João Silva'),
	  (3, 56897793821, 11968789744, 'MArcus', 'Rua Júlio Santos'),
	  (4, 56897755521, 11968695799, 'Júlio', 'Rua Pedro Antônio Galvão Junior'),
	  (5, 56333393821, 11968695788, 'Júlia', 'Rua Oliveira'),
	  (6, 56887873821, 11968695766, 'Vanessa', 'Rua dos Palmito Doce'),
	  (7, 56881293821, 11968695755, 'Antônia', 'Rua Pedro Alvares Cabral'),
	  (8, 56798493821, 11968695733, 'João Vitor', 'Rua das Pitonbas')
go




insert into Dependente (CodCliente,NomeDependente)
values (1, 'Pedro'),
	   (2, 'Lucas'),
	   (3, 'Otávio'),
	   (4, 'João Pedro'),
	   (5, 'João'),
	   (6, 'Luis'),
	   (7, 'Luna'),
	   (8, 'Luan')
go


insert into Ator (NomeAtor, DataNascimento)
values ('Paul Walker', '01-05-1980'),
	   ('Jhonny Depp', '31-06-1982'),
	   ('Bruce Lee', '21-07-1975'),
	   ('Alpachino', '11-12-1960'),
	   ('Emma Stone','01-05-1990'),
	   ('Andrew Garfild', '12-10-1991'),
	   ('Jason Statan', '07-07-1985'),
	   ('The Rock', '12-05-1987')
go


insert into Filme(NomeFilme, GeneroFilme)
values ('Velozes e Furisos','ação'),
	   ('Pitaras do Caribe','aventura'),
	   ('Dragão Branco','ação'),
	   ('Scarface','ação'),
	   ('Zumbilândia','conédia'),
	   ('O espetacular homem Aranha','fantasia'),
	   ('Adrenalina','ação'),
	   ('Jumanji','aventura')
go



insert into Filme_Ator(CodAtor, CodFilme)
values (1,1),
	   (2,2),
	   (3,3),
	   (4,4),
	   (5,5),
	   (6,6),
	   (7,7),
	   (8,8)
go



insert into Locacao (CodFilme, CodFita, CodCliente, CodFilme_Ator, QuantidadeFilmes, DataDevolucao)
values (1,1,1,1,2,'25-05-2022'), --tem que usar o apostrofo para que a data saia corretamente, senão os valores entrarão subtraindo--
	   (2,2,2,2,1,'15-05-2022'),
	   (3,3,3,3,1,'10-05-2022'),
	   (4,4,4,4,3,'20-06-2022'),
	   (5,5,5,5,1,'10-06-2022'),
	   (6,6,6,6,4,'08-06-2022'),
	   (7,7,7,7,1,'11-05-2022'),
	   (8,8,8,8,1,'15-05-2022')
go



insert into Fita (CodFilme, QuantidadeFitasPorFilme)
values(1, 100),
	  (2, 90),
	  (3, 80),
	  (4, 25),
	  (5, 15),
	  (6, 20),
	  (7, 19),
	  (8, 10)
go


--estabelecendo as relações entre tabelas

alter table Cliente
add constraint FK_LocacaoFilme_Locacao_CodLocacao foreign key (CodLocacao)
references Locacao(CodLocacao)
go


alter table Dependente
add Constraint FK_Cliente_Cod_Cliente foreign key (CodCliente)
references Cliente(CodCliente)
go


alter table Filme_Ator
add constraint FK_Ator_CodAtor foreign key (CodAtor)
references Ator(CodAtor)
go

alter table Filme_Ator
add constraint FK_Filme_CodFilme foreign key (CodFilme)
references Filme(CodFilme)
go


alter table Locacao
add constraint FK_Fita_CodFita foreign key (CodFita)
references Fita(CodFita)
go


alter table Locacao
add constraint FK_Locacao_Filme_CodFilme foreign key (CodFilme)
references Filme(CodFilme)
go


alter table Locacao
add constraint FK_Locacao_Filme_Ator_CodFilme_Ator foreign key (CodFilme_Ator)
references Filme_Ator(CodFilme_Ator)
go



alter table Fita
add constraint FK_Identificacao_Filme_CodFilme foreign key (CodFilme)  --identificacao pois identifica qual filme pertence a eeste código--
references Filme(CodFilme)
go



--Parte III--
--a. Utilize o comando Update para alterar duas linhas de registros;--
Update Dependente 
set NomeDependente ='João'
where CodDependente >=7
go

select NomeDependente from Dependente
go



--b. Exclua quatros linhas de registros;--

delete from Dependente
where CodDependente >=7
go

--c. Através do comando Alter Table adicione uma nova coluna que aceite valores nulos;--
alter table Dependente 
add Idade int null
go

--d. Remova todos os dados de uma tabela sem utilizar o comando delete; --
truncate table Dependente
go

--e. Após excluir estes dados, remova fisicamente a tabela.--
Drop Table Dependente
go



--Parte VI--

--a. Apresente todos os dados sem utilizar o símbolo de asterisco;--
select CodLocacao, CodFilme, CodFita, CodCliente, CodFilme_Ator, QuantidadeFilmes, DataLocacao, DataDevolucao
from Locacao
go


--b. Apresente todos os dados ordenados de forma decrescente;--
select CodLocacao, CodFilme, CodFita, CodCliente, CodFilme_Ator, QuantidadeFilmes, DataLocacao, DataDevolucao
from Locacao
order by CodLocacao desc
go


--c. Apresente somente uma linha de registro utilizando a cláusula where como elemento filtragem de dados; e--

select CodCliente from Locacao
where QuantidadeFilmes = 4
go


--d. Apresente as cinco primeiras linhas.--
select top 5 CodLocacao, CodFilme, CodFita, CodCliente, CodFilme_Ator, QuantidadeFilmes, DataLocacao, DataDevolucao
from Locacao
order by CodLocacao desc
go
