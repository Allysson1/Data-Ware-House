--Realizando uma simples união de valores (dados)--

select 1
Union --união de dados--
select 2
Union 
select 3
go

--realizando Union entre valores combinados com null--
--quando se utiliza o Union, por padrão na execução ele ordena os dados de forma crescente, neste caso o valor null vem primeiro--

select 1
Union
Select null
Union
Select 3
Union
select 4
go


--realizando a União Completa, considerando os valores duplicados--

select 1 as ColunaA, 2 as ColunaB
union all
select 1,2
union all
select 2,2 
union all
select 3,3
union --o union sem o 'all' remove os dados duplicados, mesmo que os unions acima possuam o 'all', os valores ainda sim são retirados--
select 3,3
go

--realizando a união de dados, utilizando tipos de dados distintos--
--o código abaixo gera erro pois apenas o union não aceita tipos de dados diferentes--
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


--utilizando convert e cast no exemplo de cima (o convert é mais flexivel para a conversão de dados do que o cast)--
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


--criando as tabelas A e B para simular a União de dados armazenados em tabelas--
create table TabelaA
(ValorA tinyint)
go


create table TabelaB
(ValorB tinyint)
go


--inserindo dados nas tabelas--
--para ser um registro lógico, não pode conter valor nulo(null)--
insert into TabelaA values (1),(2),(3), (null)
insert into TabelaB values (10),(20),(null), (0)
go

--utilizando o opeerador Union--
--o union só retira valores duplicados da mesma tabela, quando são tabelas distintas os valores podem se repetir--
select *, 'Valores A' from TabelaA
union all
select *, 'Valores B' from TabelaB
go

--inserindo 5 linhas de registros duplicadas na TabelaA--
insert into TabelaA values (200)
go 5


--removendo as linhas ou valores repetidos na apresentação de dados utilizando o operador distinct--
select distinct ValorA from TabelaA
go


--Removendo o valor nulo na apresentação dos dados obtidos pelo comando select--
select distinct ValorA from TabelaA
where ValorA is not null
go


--apresentando somente a linha com valor inteiro null--
select distinct ValorA from TabelaA
where ValorA is null
go
