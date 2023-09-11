use JuncaoCruzada
go

--removendo a anulabilidade e alterando o tipo de dados da Coluna CodigoQueimada--

alter table Queimadas1999
alter column CodigoQueimada int not null
go


--adicionando a propriedade chave primária na tabela Queimadas1999 aplicandi a coluna CodigoQueimada--
alter table Queimadas1999
add Constraint PK_Queimadas1999_CodigoQueimada primary key (CodigoQueimada)
go


--Removendo as colunas AreaIndu,FRP (frequencia do poder do fogo),LongitudeAproximada e LatitudeAproximada--
alter table Queimadas1999
drop column AreaIndu, FRP, LongitudeAproximada, LatitudeAproximada
go



--alterando o tipo de Dados da Coluna DiaSemChuva--
alter table Queimadas1999
alter column DiaSemChuva int not null
go


--Utilizando as funções Agregação e Sumarização de Dados--
select Sum(DiaSemChuva) as Somar,
ABS(sum(DiaSemChuva)) As SomaAbsoluta --ABS = valor absoluto a partir de zero em diante (Funciona como se o número fosse multiplicado por -1--
from Queimadas1999
go


--Pesquisar os paises Existentes na tabela Queimadas1999--
--distinct faz a anulação de dados duplicados--
--Len conta os caracteres
--DataLench mostra o tamanho do arquivo em disco
select distinct Pais, Len(Pais) As 'Caracteres', DATALENGTH(Pais) as 'Bytes'
from Queimadas1999
select 'Venezuela',LEN('Venezuela'),DATALENGTH('Venezuela')
go


--identificando o espaço atual ocupado pela tabela--
--sp_spaceused mostra o tamanho que a tabela ocupa em disco
Exec sp_spaceused'Queimadas1999'
go


--alterando o tamanho e tipo de dado da Coluna Pais--
alter table Queimadas1999
alter column Pais Char(6) not null
go


--aula do dia 04-05-2022--

select Satelite,
	Len(Satelite) as 'Qualidade de Caracteres',
	DATALENGtH (Satelite) as 'Quantidade de Bytes',
	Max(Len(Satelite)) as 'Tamanho Máximo de Caracteres'
from Queimadas1999
group by Satelite
go


--alterando o tamanho e tipo de Dados da coluna Satelite--
alter table Queimadas1999
alter column Satelite varchar(7) not null
go


--alterando o tipo de dados e tamanho das colunas--
alter table Queimadas1999
alter column Municipio varchar(32) not null
go


alter table Queimadas1999
alter column Estado varchar(19) not null
go


--identificando os Biomas existentes ma tabela-
select distinct Bioma from Queimadas1999
go


--excluindo os Biomas em branco--
delete from Queimadas1999
where Bioma=''
go

alter table Queimadas1999 
alter column Bioma Varchar(14) not null
go


--consultando a coluna DataHora--
select top 10 DataHora from Queimadas1999
go


--Testando o formato de apresentação de DataHor--
select CONVERT(datetime, DataHora, 102) from Queimadas1999  --102 é o código de conversão de data e Hora--
go



--alterando o formato do dado armazenado na coluna DataHora--
update Queimadas1999
set DataHora=Convert(DateTime, DataHora,102)
go


--alterando a coluna DataHora--
Alter table Queimadas1999
alter column DataHora DateTime not null
go


--Consultando a coluna RiscoFogo--
select distinct RiscoFogo from Queimadas1999
go


--alterando a coluna RiscoFogo para o Tipo de Dados Float--
--quando aparece o erro aritmetic overflow (estouro do dado aritmetico), significa que o dado a ser convertido é incompátivel com a conversão solicitada, exemplo do cpf e o telefone na lista EX1 de bancos
alter table Queimadas1999
alter column RiscoFogo float not null
go

--Numeric(5,2), o  5 é o número de casas total, 2 são as casas decimais presentes dentro das 5 casas


--consultando a coluna precipitacao--
select distinct Precipitacao from Queimadas1999
go


--alterando a coluna Precipitacao para o tipo de dados Decimal(2,1)--
alter table Queimadas1999
alter Column Precipitacao Decimal(2,1) not null
go


--Consultando as colunas LAtitude e Longitude--
select Distinct Latitude, Longitude from Queimadas1999
go


--Alterando a coluna LAtidude para o tipo de dados Decimal(18,2)--
alter table Queimadas1999
alter Column Latitude Decimal(18,2) not null
go


--a tabela Longitude teve que ser alterada para big int e posteriormente para Decimal pois os valores eram incompativeis com o Decimal(18,2)
--Alterando a coluna Longitude para o tipo de dados bigint--
alter table Queimadas1999
alter Column Longitude BigInt not null
go


--Alterando a coluna Longitude para o tipo de dados Decimal(18,2)
alter table Queimadas1999
alter Column Longitude Decimal(18,2) not null
go


--Adicinando as colunas calculadas LAtitudeAproximada e LongitudeAproximada--
alter table Queimadas1999
add LAtitudeAproximada as (Latitude+1),
	LongitudeAproximada as (Longitude+2)
go


--Adicionando  as colunas Calculadas Ano, Mês e Dia geradas de forma automática, com base no preenchimento da coluna DataHora
alter table Queimadas1999
add Ano as Year(DataHora),
	Mes as Month(DataHora),
	Dia as Day (DataHora)
go


--Consultando os dados nas novas Colunas Criadas--
--Newid() gera um novo Id para a consuta toda a vez que ela é executada, assim não permitindo a repetição de dados a cada consulta --
Select top 30
	NewID(),DataHora, Ano, Mes, Dia, 
	Latitude, LatitudeAproximada, Longitude, LongitudeAproximada
from Queimadas1999
Order by NEWID()
go