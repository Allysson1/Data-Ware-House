Create table Numeracao 
(Linha tinyint identity (1,1), 
Numeros Tinyint not null)
go


--inserindo 25 linhas de registro--
insert into Numeracao
values (1), (1), (1), (1), (1),
	   (2), (2), (2), (2), (2),
	   (3), (3), (3), (3), (3),
	   (4), (4), (4), (4), (4),
	   (5), (5), (5), (5), (5)
go


--consultando todos 0s dados inseridos na tabela Numeracao--
select Linha, Numeros from Numeracao
go


--eliminando a duplicidade de valores na aprensenta��o de dados--
select distinct Numeros from Numeracao
go


--apresentando as 10 primeiras linhas--
select top 10 Linha, Numeros from Numeracao
order by Linha asc
go


--apresentando as 10 �ltimas linhas--
select top 10 Linha, Numeros from Numeracao
order by Linha desc
go


--retornando 30 porcento das linhas exixtentes na tabela Numeracao--
select top 30 percent Linha, Numeros from Numeracao
go


--Apresentando o percentual alet�rio de linhas existentes nat tabela Numeracao--
--tinyint = inteiro curto--
Declare @Porcentagem tinyint, @Comando varchar(200)

set @Porcentagem = rand()*100

set @Comando = CONCAT('Select top ', @Porcentagem, ' Percent Linha, Numeros From Numeracao')	

--simulando um debug--
--print @Comando--

--ou--

--select @Comando

--fazer um CTRL+C CTRL+V para testar o comando--

--apresenta��o o resultado da vari�vel--
select concat(@Porcentagem,'%') as 'Porcentagem' 

--executando a query din�mica--
Exec(@Comando)
go --o go s� pode ser colocado ao final de todo o comando, caso seja colocado antes ocorrer� erro pois bloquear� o resto dos comandos 