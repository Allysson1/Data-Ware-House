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
values ('Kim', 99, 'Inglês'), ('Thomas', 95, 'Inglês'), ('jonh', 92, 'Inglês'),('MAg', 97, 'Espanhol'),
('Sussy', 90, 'Espanhol'), ('Boby', 91, 'Português'),('Datrh', 89, 'português'),('Mary', 93,'Inglês'),
('Fill', 90, 'Inglês'),('Jax', 99, 'Inglês'),('Brian', 78, 'Espanhol'),('Newton', 98, 'Espanhol'),('Philip', 91, 'Português'),
('Zub', 78, 'Português')
go



--consultando os dados--
select Codigo, Nome, Classificacao, Curso 
from Estudantes
Order by Curso desc
go



--Determinando a contagem geral de estudantes -- atraves da utilização da função de Agregação Count()--
select count(Codigo) as Quantidade
from Estudantes
go 


--realizando o agrupamento de dados através da coluna curso, estabelecendo a contagem de alunos por curso--
select count(Codigo) As Quantidade, curso
from Estudantes
Group by Curso
order by Quantidade desc
go



--Realizando o agrupamento de dados da coluna Curso, indetificando a média da Classificação--
--Quando se utiliza funções de agregação, tem que utilizar o group by--

Select Curso, Count(Codigo) as 'Quantidade', AVG(Classificacao) as 'Media' --AVG - Avarage (calcula a media) pesquisar mais sobre-- 
from Estudantes
group by Curso --o elemento group by não pode usar funções de agregação para agrupar, quando se precisa fazer esse processo, se utiliza o Having(exemplo abaixo)--
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