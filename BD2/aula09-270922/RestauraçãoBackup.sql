--restaurando o ultimo arquivo de backup
--n�o se pode estar conectado no banco que vai ser restaurado
--os comandos a seguir podem ser usados para testar um backup antes de sobir para a produ��o
use master
go


restore DataBase BancoDoBrasil
from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
with Recovery, --liberar o acesso ao banco de dados ap�s a restaura��o
	replace, --Substituir o conte�do atual pelo conte�do do backup
	stats = 5
go

--este comando abaixo tras o mesmo resultado mesmo n�o usando o Recovery
restore DataBase BancoDoBrasil
from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
with replace, --Substituir o conte�do atual pelo conte�do do backup
	stats = 5
go



--este comando abaixo tras um enorme problema, ele n�o termina a restaura��o e n�o libera o banco para uso
restore DataBase BancoDoBrasil
from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
with noRecovery,
	replace,
	stats = 5
go


--este comando resolve o problema do codigo acima



--utilizando o backup de um outro banco, � possivel criar um novo
--restaurando um backup e criando um novo banco de dados
--passo 1 -  Apresentar a lista de arquivos contidos no arquivo de dados e log
Restore FileListOnly from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
go

--passo 2- Definir as propriedades para os arquivos de dados e log
restore DataBase BancoDoBrasil2022
from disk = 'C:\DataBase\Backup-Database-BancoDoBrasil3.bak'
with Recovery, --liberar o acesso ao banco de dados ap�s a restaura��o
	replace, --Substituir o conte�do atual pelo conte�do do backup
	stats = 5,
	move 'BancoDoBrasil' to	'C:\DataBase\DATA\BancoDoBrasil2022.MDF',
	move 'BancoDoBrasil_Log' to	'C:\DataBase\LOG\BancoDoBrasil2022-log.LDF'
go