--criando o banco
create database BancoDeDadosIIListaI
go 

--selecionando o banco
use BancoDeDadosIIListaI
go


--criando a tabela de Disciplinas
create table Disciplinas
(CodigoDisciplina int not null identity(1,1) primary key,
CodigoProfessor  int not null,
NomeDisciplina varchar(30) not null
)
go


--criando a tabela de professores
create table Professores 
(CodigoProfessor int not null identity(1,1) primary key,
Nome varchar(20) not null,
DataCadastro datetime not null)
go





--inserindo dados na tabela de Disciplinas
insert into Disciplinas (NomeDisciplina, CodigoProfessor)
values ('Matematica', 1),
	   ('História', 2),
	   ('Português', 3),
	   ('Ciências', 4),
	   ('Geografia', 5),
	   ('Artes', 6),
	   ('Educação Física', 7),
	   ('Sociologia', 8),
	   ('Literatura', 9),
	   ('Estatística', 10),
	   ('Inglês', 11),
	   ('Espanhol', 12),
	   ('Programação', 13),
	   ('Ginástica', 14),
	   ('Design', 15)
go



--inserindo dados na tabela de Professores


insert into Professores(Nome, DataCadastro)
values ('Allysson', '01-10-2022'),
	   ('João', '01-09-2022'),
	   ('Pedro', '30-10-2022'),
	   ('Antonio', '21-10-2022'),
	   ('Julia' , '31-10-2022'),
	   ('Ariana', '01-10-2022'),
	   ('Julio', '01-10-2021'),
	   ('Antonia', '01-9-2019'),
	   ('Anderson', '15-10-2022'),
	   ('Wellington', '01-01-2022'),
	   ('Messias', '21-09-2022'),
	   ('Ketelin', '11-09-2011'),
	   ('Icaro', '21-10-2022'),
	   ('Gabriel', '22-04-2022'),
	   ('Micaela', '01-02-2022')
go




--estabelecendo o relacionamento


alter table Disciplinas
add constraint FK_CodigoProfessor_Professores foreign key (CodigoProfessor)
references Professores(CodigoProfessor)
go



--consultando inserts
select * from Disciplinas
go
select * from Professores
go


--junção entre as tabelas Professores e Disciplinas no mesmo comando Select através do operador de junção Inner Join
select D.NomeDisciplina, P.Nome as 'Nome Do Professor'
from Disciplinas D inner join Professores P
on D.CodigoProfessor = P.CodigoProfessor
go


--apresentando somente os professores que possuem através da coluna CodigoProfessor o valor maior que 10;
select D.NomeDisciplina, P.Nome as 'Nome Do Professor'
from Disciplinas D inner join Professores P
on D.CodigoProfessor = P.CodigoProfessor
where D.CodigoProfessor > 10
go

--trazendo somente os professores que possuem através da coluna DataCadastro valores exclusivos de datas entre os dias: 2022-10-01 e 2022-10-30
select D.NomeDisciplina, P.Nome as 'Nome Do Professor', p.DataCadastro
from Disciplinas D inner join Professores P
on D.CodigoProfessor = P.CodigoProfessor
where P.DataCadastro >= '01-10-2022' and P.DataCadastro <= '30-10-2022'
go


--declarando  um bloco de código contendo o comando Select apresentando 10 linhas de registro armazenados na tabela Disciplinas;
select top 10 * 
from Disciplinas
go



-- Declarando o comando union das tabelas de Disciplinas e Professores
select top 10 NomeDisciplina, CodigoProfessor
from Disciplinas

union 

Select top 10 Nome, CodigoProfessor from Professores
go



