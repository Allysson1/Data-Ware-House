Use Juncoes
go

--realizando Uni�o de Dados emconjunto com jun��o d tabelas--
create table Professores
(CodigoProfessor int primary key,
Nome varchar(20) not null)
go

insert into Professores (CodigoProfessor, Nome) values(1,'Chico Dito'), (2,'Maria Louca')
go


create table Disciplinas 
(CodidoDisciplina int Primary key,
CodigoProfessor int not null,
NomeDisciplina varchar(30) not null)
go

insert into Disciplinas (CodidoDisciplina, CodigoProfessor, NomeDisciplina)
values (1,1,'Sociologia'), (2,2,'Matem�tica'), (3,3, 'Hist�ria')
go


--Jun��o com inner join--
select P.CodigoProfessor, P.Nome, D.CodidoDisciplina, D.NomeDisciplina
from Professores P inner join Disciplinas D
						on P.CodigoProfessor = D.CodigoProfessor  --quando se utiliza o inner join, o elemento 'On' � obrigat�rio, pois o inner join requer itens verdadeiros--
go


insert into Professores values (3,	'Alberto Gordo')
go


insert into Disciplinas (CodidoDisciplina, CodigoProfessor, NomeDisciplina)
values (6,3,'Hist�ria')
go



