--Modificando a criação inicial do banco de dados

--Exemplo 1 - Especificando as configurações básicas

create database FatecSR2022
on primary 
	(Name = 'FatecSR2022-Data', --Nome interno do arquivo--
	FileName = 'C:\DataBase\DATA\FatecSR2022-Data.MDF',  --Caso não haja as pastas no 'C:', tem que criar
	Size = 50 MB, --tamanho inicial
	MaxSize = 500 MB, -- Tamanho Máximo de crescimento
	FileGrowth = 10 MB) --FAtor de Crescimento

log on

	(Name = 'FatecSR2022-Log',
	FileName = 'C:\DataBase\LOG\FatecSR2022-Log.LDF',
	size = 100 MB,
	MAxSize = Unlimited,
	FileGrowth = 10%)
	go




--Exemplo 2 - Criando um novo Banco de Dados com dois arquivos de dados e um arquivo de log--
--a distribuição de dados entre os dois arquivos de DATA ocorre automáticamente
Create Database FatecBDTTwoFiles
on primary
	(Name = 'FatecBDTTwoFiles-Data',
	FileName = 'C:\DataBase\DATA\FatecBDTTwoFiles-Data.MDF',  --MDF é o arquivo primario
	Size = 40 MB,
	MaxSize = 4GB,
	FileGrowth = 100 MB),

	(Name = 'FatecBDTTwoFiles-Data-1',
	FileName = 'C:\DataBase\DATA\FatecBDTTwoFiles-Data-1.NDF', --NDF é o arquivo secundário e todos os outros posteriores a ele.
	Size = 80 MB,
	MaxSize = 8192GB,
	FileGrowth = 1 GB)

log on
	(Name = 'FatecBDTTwoFiles-Log-1',
	FileName = 'C:\DataBase\LOG\FatecBDTTwoFiles-Log-1.LDF',
	Size = 1024 MB,
	MaxSize = Unlimited,
	FileGrowth = 25%)
	go




--Se cria grupo de arquivos na criação  do banco de dados para ganho de performance - exemplo, um arquivo de DATA no disco C:, e outro no disco D:
--Ajuda no Backup, restauração, armazenamento...
--configuração importante em pequenas empresas sem auto investimento para um ganho de performance


Create Database FatecBDTTwoFileGroups
on primary --Sempre tem que ser primary aqui
	(Name = 'FatecBDTFilesGorups-Data',
	FileName = 'C:\DataBase\DATA\FatecBDTFileGorups-Data.MDF',  
	Size = 50 MB,
	MaxSize = 500GB,
	FileGrowth = 10 MB),

fileGroup Secondary --posso colocar qualquer nome que eu quiser a partir do segundo grupo
	(Name = 'FatecBDTFileGroups-Data-Secondary',
	FileName = 'C:\DataBase\DATA\FatecBDTFileGoups-Secondary.MDF', --neste caso como o arquivo é o principal de um grupo secundário, se usa .MDF 
	Size = 500 MB,
	MaxSize = 5000MB,
	FileGrowth = 2 GB)

log on
	(Name = 'FatecBDTFileGroups-Log',
	FileName = 'C:\DataBase\LOG\FatecBDTFileGroups-Log.LDF',
	Size = 5 MB,
	MaxSize = Unlimited,
	FileGrowth = 5%)
	go





--acessando o banco 
use FatecBDTTwoFileGroups
go

--Criando a Tabela T1 No FileGroup Primary--
create table T1
(Codigo int)
on [Primary] --comando para salvar a tabela no grupo primário
go


create table T2
(Codigo int)
on [Secondary] --comando para salvar a tabela no grupo secundário
go


--o select para as tabelas continua padrão independentemente do grupo.
select * from T1

Select Codigo from T2
go








--Iniciando backup
--banco de dados pode ser feito o backup mesmo que esteja rodando(em uso)
--banco de dados não pode ser recuperado em uso. todos tem que desconectar-se do banco para que isso ocorra
create database BancoDoBrasil
go


Use BancoDoBrasil
go


--alterando o Modelo de Recuperação para Simple--
alter database BancoDoBrasil
set recovery simple   --tem trés tipos, simple, full e bucky logged
go


backup Database BancoDoBrasil
to disk =  'C:\DataBase\Backup-Database-BancoDoBrasil3.bak' --caminho e local de armazenamento do arquivo.
with init, --especifica que um novo arquivo de backup deverá ser criado caso já exista um com o mesmo nome  (sobescreve o arquivo antido)--
Description = 'Meu Arquivo de Backup', -- Descricao fo arquivo de Backup--
stats= 5 -- barra de progresso
go



--criando uma tabela para simular a inserção de dados--
create table Valores
(Codigo int primary key identity(1,2),
valor1 bigint default 1000000,
valor2 bigint default 20000000)
go



insert into Valores default values
go 400000

--consultando top 2000 registros lógicos de forma aleatória
select top 2000 * from Valores
Order by NEWID() --ordenando de forma aleatória com base nos valores gerados pela função NewID()
go



--consultando o tamanho atual dos arquivos que formam o Banco de Dados--
select filename, (size*8) as KBs, (Size/1024)*8 as 'MBs' --8 por que corresponde ao valor de 1 byte
from Sys.sysfiles
go


--alterando o Modelo de Recuperação para full(completo)--
alter database BancoDoBrasil
set Recovery full 
go



backup log BancoDoBrasil
to disk = 'C:\DataBase\Backup-log-BancoDoBrasil.trn'
with init,
Description = 'Backup do arquivo de log',
ExpireDate = '30-09-2022', --data de validade do backup--
stats = 10
go