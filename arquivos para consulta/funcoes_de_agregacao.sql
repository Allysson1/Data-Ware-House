create database AgruparDados
go 

use AgruparDados
go

--Criando a tabela Estudantes--
Create table Estudantes
(Codigo int primary key identity(1,1),
Nome varchar(20) not null,
Classificacao tinyint not null,
Curso varchar(20) not null)
go


--Inserindo os dADOS NA tABELA estudantes--
Insert into Estudantes (Nome, Classificacao, Curso)
values ('Kim', 99, 'Ingl�s'), ('Thomas', 95, 'Ingl�s'), ('jonh', 92, 'Ingl�s'),('MAg', 97, 'Espanhol'),
('Sussy', 90, 'Espanhol'), ('Boby', 91, 'Portugu�s'),('Datrh', 89, 'portugu�s'),('Mary', 93,'Ingl�s'),
('Fill', 90, 'Ingl�s'),('Jax', 99, 'Ingl�s'),('Brian', 78, 'Espanhol'),('Newton', 98, 'Espanhol'),('Philip', 91, 'Portugu�s'),
('Zub', 78, 'Portugu�s')
go



--consultando os dados--
select Codigo, Nome, Classificacao, Curso 
from Estudantes
Order by Curso desc
go



--Determinando a contagem geral de estudantes -- atraves da utiliza��o da fun��o de Agrega��o Count()--
select count(Codigo) as Quantidade
from Estudantes
go 


--realizando o agrupamento de dados atrav�s da coluna curso, estabelecendo a contagem de alunos por curso--
select count(Codigo) As Quantidade, curso
from Estudantes
Group by Curso
order by Quantidade desc
go



--Realizando o agrupamento de dados da coluna Curso, indetificando a m�dia da Classifica��o--
--Quando se utiliza fun��es de agrega��o, tem que utilizar o group by--

Select Curso, Count(Codigo) as 'Quantidade', AVG(Classificacao) as 'Media' --AVG - Avarage (calcula a media) pesquisar mais sobre-- 
from Estudantes
group by Curso --o elemento group by n�o pode usar fun��es de agrega��o para agrupar, quando se precisa fazer esse processo, se utiliza o Having(exemplo abaixo)--
order by Media asc
go


Select Curso, Count(Codigo) as 'Quantidade', AVG(Classificacao) as 'Media' --AVG - Avarage (calcula a media) pesquisar mais sobre-- 
from Estudantes
group by Curso 
having avg(Classificacao)>=90
order by Media asc
go


Select Curso, Count(Codigo) as 'Quantidade', AVG(Classificacao) as 'Media' --AVG - Avarage (calcula a media) pesquisar mais sobre-- 
from Estudantes
where Classificacao>=90
group by Curso 
order by Media asc
go



--menor valor e maior
select min (Classificacao) as Menor ,
max(Classificacao) as Maior,
Sum(Classificacao) as Soma
from Estudantes
go