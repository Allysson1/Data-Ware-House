use RestricoesDeIntegridade
go


--alterando o valor da coluna sexo--
Update Pessoas
set Sexo = 'F'
where Codigo >=800
go


--atualizando as colunas DataCadastro e Nome--
Update Pessoas
Set DataCadastro = GetDate(), Nome = 'Pessoas Bonitas'
where Codigo Between 357 and 481
go


--Consultando utilizando o operador Like para realizar a busca aproximada de valores caracteres--
select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas
where Nome like '% Bonitas' --o % seleciona os dados que possuem o valor apresentado em seguida ao % (tudo o que vem depois do valor)--
go


select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas
where Nome like 'Pessoas %' --o % seleciona os dados que possuem o valor apresentado antes do % (tudo o que vem antes do valor)--
go


--exemplo 1--
--subQuery - um select dentro de outro
select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas
where Codigo in (select Codigo from Pessoas where Nome like '%pessoas%') 
go

--exemplo 2--
select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas --select principal--
where Codigo not in (select Codigo from Pessoas where Salario >=500) --subquery--
go

--exemplo 3--
select Codigo, Nome, Sexo, DataCadastro, Salario from Pessoas
where exists (select Codigo from Pessoas where Salario >=500) 
go


--trabalhando com funções de data e hora--
select getdate()+2 as 'data atual + 2 dias', getdate()-120 as 'Data atual - 120 dias' --getdate pega a data do pc--

select YEAR(getdate()) as 'Ano', --Ano
	MONTH(GetDate()) as 'Mês', --mês atual
	DAY(getdate()) as 'Dia', --dia atual
	DATEDIFF(day,'02-04-2019', getdate()) as 'Diferença entre datas', --diferença entre datas
	EOMONTH(getDate()) as 'Ultimo dia do mês', --ultimo dia do mês
	DATEADD(minute,-10,Getutcdate()) as	'Incremento ou decremento', --data e hora de onde você se encontra sem ser o do seu pc (cordenada mundial de tempo (fuso horario))
	SYSDATETIME() as 'Data e hora do sistema',
	DATENAME(MONTH,GETDATE()) as 'Nome do Mês',
	case DATEPART(weekday,getdate())
	when 1 then 'Domingo'
	when 2 then 'Segunda-feira'
	when 3 then 'terça-feira'
	when 4 then 'quarta-feira'
	when 5 then 'quinta-feira'
	when 6 then 'sexta-feira'
	when 7 then '´sábado'
	end as 'Dia da semana'
go
