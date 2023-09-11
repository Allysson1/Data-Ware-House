use master
go

--validando a estrutura fisica e lógica dos arquivos armazenados no arquivo de backup
--Passo 1 - Apresentar a lista de arquivos contidos no arquivo de backup--
Restore FileListOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go

--Passo 2 - verificando o integridade do arquivo Backup-- caso não funcione este comando, o backup não pode ser restaurado
restore VerifyOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go

--passo 3 - Verificando a consistência do cabeçalho do arquivo de Backup -- caso não funcione este comando, o backup não pode ser restaurado 
Restore HeaderOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go


--passo 4 - Obter as informações sobre a ferramenta utilizada no processo de backup--
restore LAbelOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
go