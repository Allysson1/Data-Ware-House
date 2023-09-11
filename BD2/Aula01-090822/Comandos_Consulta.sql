Use Sargable
go

--exemplo - conslta NonSARgable(N�o Capaz de ser pesquisado) -- Utilizando a fun��o Left() na clausura Where--
select FirstName from Person
where LEFT(FirstName,1) ='K'
go


--like -e um tipo de pesquisa aproximada, "%" representa o coringa , este comando traz uma melhor pesquisa e � mais r�pido em rela��o ao comando anterior left() . Utilize o "incluir plano de execu��o" na barra de ferramentas superior para entender melhor
select FirstName from Person
where FirstName like 'K%'
go


--Exemplo 2 - NonSARgable -- utlilizando a fun��o Year() para pesquisar o ano--
select ModifiedDate From Person
where Year(ModifiedDate) = 2009
go





--comando mais preciso com between--
select ModifiedDate From Person
where ModifiedDate Between '20090101' and '20091231'
go




--ativando o contador de tempo de processamento(Time)
--executa-se este comando primeiro e depois o de consulta
set Statistics time on --contador de tempo
go

--desativando o contador de tempo
set Statistics time off
go



--ativando a contagem de leituras em disco
set statistics IO on
go

--desativando a contagem de leituras em disco
set statistics IO off
go


--Exemplo 3 NonSARgable -- Utilizando a fun��o isNull() na cl�usura Where . IsNull busca por valores nulos e o substitui por um valor setado, neste caso o 'E'--
Select MiddleName from Person
Where ISNULL(MiddleName,'E')='E'
go



--Comando executado com Is Null (mesmo nome da anterior, por�m separado)
--Quando aparece uma mensagem de 'Indice ausente' no plano de execu��o, ele d� uma dica de como melhorar a busca realizada 
Select MiddleName from Person
Where MiddleName is null
or MiddleName = 'E'
go