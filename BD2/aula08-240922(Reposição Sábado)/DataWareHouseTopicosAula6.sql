Create Database TopicosAula6

use TopicosAula6


--criando uma dados massivos
Create table Calendario
(CodigoClendario Int identity(1,1) Primary key Clustered,
DataCalendario DateTime)
Go

Declare @Contador Int

Set @Contador=1

While @Contador <=10000
Begin

Insert Into Calendario Values (GetDate ()+@Contador)

Set @Contador = @Contador+1

End
Go

Select * From Calendario
Go




-- Criando a Dimensão Tempo - DimTime --
Create Table DimTime
(TimeID Int Identity(1,1) Not Null,
Dia TinyInt Not Null,
DiaDaSemana TinyInt Not Null,
DiaDaSemanaPorExtenso Varchar(15) Not Null,
DiaDoMes TinyInt Not Null,
DiaNoAno SmallInt Not Null,
Semana TinyInt Not Null,
SemanaNoMes TinyInt Not Null,
SemanaNoAno TinyInt Not Null,
PrimerioDiaDaSemana TinyInt Not Null,
UltimoDiaDaSemana TinyInt Not Null,
Mes TinyInt Not Null,
MesPorExtenso Varchar(15) Not Null,
Quartil TinyInt Not Null,
MesQuartil TinyInt Not Null,
QuartilPorExtenso Varchar(20) Not Null,
Ano Int Not Null,
AnoPorExtenso Varchar(40) Not Null,
DataAtual Date Not Null,
HoraAtual Time Not Null,
DataHora DateTime Not Null,
Horas TinyInt Not Null,
Minutos TinyInt Not Null,
Segundos TinyInt Not Null,
FeriadoPorExtenso Varchar(15) Not Null
Constraint [PK_DimTime_TimeID] Primary Key Clustered (TimeID))
Go





--Exemplo de como executar um Backup
--Alternar o modelo de recuperação do banco de dados--


--extenções de arquivos que podem ser usados no Backup
-- .bak - backup dados ou log
-- .Bkp - backup dados ou log
-- .trn - Backup log

alter database TopicosAula6
set recovery Bulk_Logged
go


--apresentando a datatual e Hora
select GETDATE() as DataCalendarioAtual
go


--definindo o domigo como o primeiro dia da semana
set DateFirst 1
go

--exemplo abaixo trás apenas um select do dia de hoje
--dimensionando com base no valor da data e hora os atributos realizados ao assunto
select Day(GETDATE()) as Dia,
	DATEPART(DW,GETDATE()) as DiaDaSemana,
	case DatePart(DW, GetDate())
		when 1 then 'Segunda-Feira'
		when 2 then 'Terça-Feira'
		when 3 then 'Quarta-Feira'
		when 4 then 'Quinta-Feira'
		when 5 then 'Sexta-Feira'
		when 6 then 'Sábado'
		when 7 then 'Domingo'
	end As DiaDaSemanaPorExtenso,
	DatePart(D, GetDate()) as DiaDoMes,
	DATEPART(DAYOFYEAR, GETDATE()) as DiaDoAno,
	DatePart(Week, GetDate()) as Semana, 
	DatePArt(Day,DATEDIFF(Day,0, GetDAte())/7*7)/7+1 as SemanaNoMes,
	DatePart(WEEK, GEtDate()) as SemanaNoAno,
	DAy(DateADD(Week, DateDiff(Week, 0, GetDate()),0)) as PrimeiroDiaDaSemana,
	DAy(DateADD(Week, DateDiff(Week, 0, GetDate()),7)) as UltimoDiaDaSemana,
	MONTH(GETDATE()) as Mes,
	
	case Month(GetDate())
		when 1 then 'Janeiro'
		when 2 then 'Fevereiro'
		when 3 then 'Março'
		when 4 then 'Abril'
		when 5 then 'Maio'
		when 6 then 'Junho'
		when 7 then 'Julho'
		when 8 then 'Agosto'
		when 9 then 'Setembro'
		when 10 then 'Outubro'
		when 11 then 'Novembro'
		when 12 then 'Dezembro'
	end As MesPorExtenso,
	
	Case
		when DAtepaRT(Q, gETdATE()) = 1 AND MONTH(GETDATE()) = 1 then 1
		when DAtepaRT(Q, gETdATE()) = 1 AND MONTH(GETDATE()) = 2 then 1
		when DAtepaRT(Q, gETdATE()) = 1 AND MONTH(GETDATE()) = 3 then 1
		when DAtepaRT(Q, gETdATE()) = 2 AND MONTH(GETDATE()) = 4 then 2
		when DAtepaRT(Q, gETdATE()) = 2 AND MONTH(GETDATE()) = 5 then 2
		when DAtepaRT(Q, gETdATE()) = 2 AND MONTH(GETDATE()) = 6 then 2
		when DAtepaRT(Q, gETdATE()) = 3 AND MONTH(GETDATE()) = 7 then 3
		when DAtepaRT(Q, gETdATE()) = 3 AND MONTH(GETDATE()) = 8 then 3
		when DAtepaRT(Q, gETdATE()) = 3 AND MONTH(GETDATE()) = 9 then 3
		when DAtepaRT(Q, gETdATE()) = 4 AND MONTH(GETDATE()) = 10 then 4
		when DAtepaRT(Q, gETdATE()) = 4 AND MONTH(GETDATE()) = 11 then 4
		when DAtepaRT(Q, gETdATE()) = 4 AND MONTH(GETDATE()) = 12 then 4
	end as MesQuartil, 
	DATEPART(Q, GETDATE()) as Quartil,

	CAse DATEPART(Q,GetDAte())
		when 1 then 'Primeiro Quartil'
		when 2 then 'Segundo Quartil'
		when 3 then 'Terceiro Quartil'
		when 4 then 'Quarta Quartil'
	End as QuartilPorExtenso,
	DATEPART(YEAR, GETDATE()) as Ano,
	'Dois mil e vinte e dois' as AnoPorExtenso,
	convert(date, GETDATE()) as 'Data',
	Convert(Time, getdate()) as 'Hora atual',
	getdate() as 'Data e hora atual',
	DATEPART(hour,GETDATE()) as horas,
	DatePart(Minute, GETDATE()) as Minuto,
	 
	 case 
		when DAY(gETdATE()) = 01 AND MONTH(GETDATE()) = 01 then 'Feriado'
		when DAY(gETdATE()) = 21 AND MONTH(GETDATE()) = 04 then 'Feriado'
		when DAY(gETdATE()) = 01 AND MONTH(GETDATE()) = 05 then 'Feriado'
		when DAY(gETdATE()) = 07 AND MONTH(GETDATE()) = 09 then 'Feriado'
		when DAY(gETdATE()) = 12 AND MONTH(GETDATE()) = 10 then 'Feriado'
		when DAY(gETdATE()) = 02 AND MONTH(GETDATE()) = 11 then 'Feriado'
		when DAY(gETdATE()) = 15 AND MONTH(GETDATE()) = 11 then 'Feriado'
		when DAY(gETdATE()) = 25 AND MONTH(GETDATE()) = 12 then 'Feriado'
	else 'Não è feriado'
	End as FeriadoPorExtenso
	go



		
		







--este exemplo é diferente do de cima, pois insere um select da tabela de Calendário dentro da tabela DimTime


Insert Into DimTime ([Dia], [DiaDaSemana], [DiaDaSemanaPorExtenso], [DiaDoMes],
                                      [DiaNoAno], [Semana], [SemanaNoMes], [SemanaNoAno], [PrimerioDiaDaSemana], 
                                      [UltimoDiaDaSemana], [Mes], [MesPorExtenso], [Quartil], [MesQuartil], [QuartilPorExtenso], 
                                      [Ano], [AnoPorExtenso], [DataAtual], [HoraAtual], [DataHora], [Horas], [Minutos], [Segundos], [FeriadoPorExtenso])
Select Day(DataCalendario) As Dia,
       Datepart(DW, DataCalendario) As DiaDaSemana,
       Case Datepart(DW, DataCalendario)
        When 1 Then 'Segunda-Feira'
        When 2 Then 'Terça-Feira'
        When 3 Then 'Quarta-Feira'
        When 4 Then 'Quinta-Feira'
        When 5 Then 'Sexta-Feira'
        When 6 Then 'Sábado'
        When 7 Then 'Domingo'
       End As DiaDaSemanaPorExtenso,
       Datepart(D, DataCalendario) As DiaDoMes,
       Datepart(DayOfYear, DataCalendario) As DiaDoAno,
       DatePart(Week, DataCalendario) As Semana,
       Datepart(Day, Datediff(day, 0, DataCalendario)/7 * 7)/7 + 1 As SemanaNoMes,
       DatePart(Week, DataCalendario) As SemanaNoAno,
       Day(DateAdd(Week, Datediff(Week, 0, DataCalendario), 0)) As PrimeiroDiaDaSemana,
       Day(DateAdd(Week, Datediff(Week, 0, DataCalendario), 7)) As UltimoDiaDaSemana,
       Month(DataCalendario) As Mes,
       Case Month(DataCalendario) 
        When 1 Then 'Janeiro'
        When 2 Then 'Fevereiro'
        When 3 Then 'Março'
        When 4 Then 'Abril'
        When 5 Then 'Maio'
        When 6 Then 'Junho'
        When 7 Then 'Julho'
        When 8 Then 'Agosto'
        When 9 Then 'Setembro'
        When 10 Then 'Outubro'
        When 11 Then 'Novembro'
        When 12 Then 'Dezembro'
       End As MesPorExtenso,
       DatePart(Q, DataCalendario) As Quartil,
       Case 
        When DatePart(Q, DataCalendario) = 1 And Month(DataCalendario) = 1 Then 1
        When DatePart(Q, DataCalendario) = 1 And Month(DataCalendario) = 2 Then 1
        When DatePart(Q, DataCalendario) = 1 And Month(DataCalendario) = 3 Then 1
        When DatePart(Q, DataCalendario) = 2 And Month(DataCalendario) = 4 Then 2
        When DatePart(Q, DataCalendario) = 2 And Month(DataCalendario) = 5 Then 2
        When DatePart(Q, DataCalendario) = 2 And Month(DataCalendario) = 6 Then 2
        When DatePart(Q, DataCalendario) = 3 And Month(DataCalendario) = 7 Then 3
        When DatePart(Q, DataCalendario) = 3 And Month(DataCalendario) = 8 Then 3
        When DatePart(Q, DataCalendario) = 3 And Month(DataCalendario) = 9 Then 3
        When DatePart(Q, DataCalendario) = 4 And Month(DataCalendario) = 10 Then 4
        When DatePart(Q, DataCalendario) = 4 And Month(DataCalendario) = 11 Then 4
        When DatePart(Q, DataCalendario) = 4 And Month(DataCalendario) = 12 Then 4
       End As MesQuartil,
       Case DatePart(Q, DataCalendario)
        When 1 Then 'Primeiro Quartil'
        When 2 Then 'Segundo Quartil'
        When 3 Then 'Terceiro Quartil'
        When 4 Then 'Quarto Quartil'
       End As QuartilPorExtenso,
       DatePart(Year,DataCalendario) As Ano,
       'Dois mil e Vinte e Dois' As AnoPorExtenso,
       Convert(Date, DataCalendario) As Data,
       Convert(Time, DataCalendario,114) As HoraAtual,
       DataCalendario As DataAtual,
       Datepart(HOUR, DataCalendario) As Horas,
       Datepart(MINUTE, DataCalendario) As Minutos,
       Datepart(MINUTE, DataCalendario) As Segundos,
       Case 
        When Day(DataCalendario) = 01 And Month(DataCalendario)=01 Then 'Feriado'
        When Day(DataCalendario) = 21 And Month(DataCalendario)=04 Then 'Feriado'
        When Day(DataCalendario) = 01 And Month(DataCalendario)=05 Then 'Feriado'
        When Day(DataCalendario) = 07 And Month(DataCalendario)=09 Then 'Feriado'
        When Day(DataCalendario) = 12 And Month(DataCalendario)=10 Then 'Feriado'
        When Day(DataCalendario) = 02 And Month(DataCalendario)=11 Then 'Feriado'
        When Day(DataCalendario) = 15 And Month(DataCalendario)=11 Then 'Feriado'
        When Day(DataCalendario) = 25 And Month(DataCalendario)=12 Then 'Feriado'
       Else 'Não é feriado'
       End As FeriadoPorExtenso
From Calendario
Go



-- Consultando 1000 registros lógicos da Dimensão DimTime --
Select Top 1000 * From DimTime
Go


--NEWID gera um código aleatório qeu nunca se repete
-- Consultando 2000 registros lógicos da Dimensão DimTime de forma aleatória --
Select Top 2000 * From DimTime
Order By NewID()
Go

-- Consultando 2000 registros lógicos da Dimensão DimTime com base no ano --
Select Top 2000 * From DimTime
Where Ano In (2030, 2034, 2045, 2047, 2050)
Order By NewID()
Go

