use RestricoesDeIntegridade
go

--implementando o uso de ordenação de dados--
--exemplo 1 -- Ordenando valores inteiros em ordem decrescente--
select Numeros
from (values(1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) as Valores(Numeros)
order by Numeros desc
go

--exemplo 2 -- ordenando valores caracteres em ordem crescente--
select Numeros
from (values(1),(2),(3),(4),(0),(6),(8),(null)) as Valores(Numeros)
order by Numeros desc
go


--exemplo 3-- Ordenando valores caracteres em ordem decrescente--
select Texto
from (values('1'),('2'),('3'),(null),('5'),('6)'),('a'),('8'),('9)'),('xdf'),('4sfd'),('Pedro')) as Valores(Texto)
order by Texto desc
go

--exemplo 4-- ordenando valores caracteres em ordem crescente--
select Texto
from (values('1'),('2'),('3'),(null),('5'),('6)'),('a'),('8'),('9)'),('xdf'),('4sfd'),('Pedro')) as Valores(Texto)
order by Texto asc
go


/*Exemplo 9 -- Ordenando valores caracteres em ordem crescente através do código,
apresentando as linhas a partir fo segundo registro*/

select Codigo, Descricao
from(
values (1,'Arroz'),(2,'Feijão'),(3,'Bolcha'),(4,'Fruta'),(5,'Legumes'),(6,'Molho')
)as Produtos(Codigo, Descricao)
order by Codigo asc
offset 1 row -- Estabelecendo o novo conjunto de linhas ou posição inicial
go


--Exemplo 10 -- ordenando valores caracteres em ordem crescente atraves de codigo, apresentando as linhas
select Codigo, Descricao
from(
values (1,'Arroz'),(2,'Feijão'),(3,'Bolcha'),(4,'Fruta'),(5,'Legumes'),(6,'Molho')
)as Produtos(Codigo, Descricao)
order by Codigo asc
offset 2 row -- Estabelece o novo conjunto de linhas ou posição inicial
fetch next 3 rows only --determina a quantidade de linhas retornadas em tela logo após posição inicial definina
go 