create database Agosto2022
go

use Agosto2022
go

--Obtendo informações sobre o banco de dados através da tabela de sistema sys.databases

select name, database_id, compatibility_level as 'Nivel de Compatibilidade',
recovery_model as 'ID-Modelo Recuperação',
Recovery_model_Desc as 'Modelo de recuperação'
from sys.databases
where name = 'Agosto2022'
go