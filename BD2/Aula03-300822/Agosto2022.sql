create database Agosto2022
go

use Agosto2022
go

--Obtendo informa��es sobre o banco de dados atrav�s da tabela de sistema sys.databases

select name, database_id, compatibility_level as 'Nivel de Compatibilidade',
recovery_model as 'ID-Modelo Recupera��o',
Recovery_model_Desc as 'Modelo de recupera��o'
from sys.databases
where name = 'Agosto2022'
go