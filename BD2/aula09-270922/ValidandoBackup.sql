use master
go

--validando a estrutura fisica e l�gica dos arquivos armazenados no arquivo de backup
--Passo 1 - Apresentar a lista de arquivos contidos no arquivo de backup--
Restore FileListOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go

--Passo 2 - verificando o integridade do arquivo Backup-- caso n�o funcione este comando, o backup n�o pode ser restaurado
restore VerifyOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go

--passo 3 - Verificando a consist�ncia do cabe�alho do arquivo de Backup -- caso n�o funcione este comando, o backup n�o pode ser restaurado 
Restore HeaderOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil.bak'
go


--passo 4 - Obter as informa��es sobre a ferramenta utilizada no processo de backup--
restore LAbelOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
go