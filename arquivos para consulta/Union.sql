--Realizando uma simples uni�o de valores (dados)--

select 1
Union --uni�o de dados--
select 2
Union 
select 3
go

--realizando Union entre valores combinados com null--
--quando se utiliza o Union, por padr�o na execu��o ele ordena os dados de forma crescente, neste caso o valor null vem primeiro--

select 1
Union
Select null
Union
Select 3
Union
select 4
go


--realizando a Uni�o Completa, considerando os valores duplicados--

select 1 as ColunaA, 2 as ColunaB
union all
select 1,2
union all
select 2,2 
union all
select 3,3
union --o union sem o 'all' remove os dados duplicados, mesmo que os unions acima possuam o 'all', os valores ainda sim s�o retirados--
select 3,3
go

--realizando a uni�o de dados, utilizando tipos de dados distintos--
--o c�digo abaixo gera erro pois apenas o union n�o aceita tipos de dados diferentes--
select 1,1
union 
select 1,2 
union 
select 0,1
union
select null, 0
union 
select 'ABC'
go


--utilizando convert e cast no exemplo de cima (o convert � mais flexivel para a convers�o de dados do que o cast)--
select CONVERT(char(1),1) as 'coluna A', 1 as 'Coluna B'
union 
select cast(1 as varchar(2)),2 
union 
select convert(char(2),0),1
union
select null,0
union 
select 'ABC',0
order by [coluna A] desc
go