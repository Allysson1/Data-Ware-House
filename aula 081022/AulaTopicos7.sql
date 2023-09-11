-- Criando o Banco de Dados TopicosAula07 --
Create Database TopicosAula07
Go

-- Acessando o Banco de Dados TopicosAula07 --
Use TopicosAula07
Go

-- Passo 1 -- Criando a Tabela de Vendas para armazenar dados transacionais --
-- Criando a Tabela Vendas --
Create Table Vendas
 (CodigoVenda Int Identity(1,1) Primary Key,
  CodigoDoCliente Int Not Null, 
  CodigoDoFuncionario Int Not Null, 
  CodigoDoEntregador Int Not Null,
  CodigoDoProduto Int Not Null, 
  TimeID Int Not Null,
  Itens TinyInt,
  Valor Numeric(4,2) Default 10.00,
  Contador TinyInt Default 1)
Go

-- Passo 2 - Criando a Tabela de Histórico de Vendas para trabalhar como Área de Staging --
-- Criando a Tabela Vendas --
Create Table HistoricoVendas
 (CodigoHistoricoVenda Int Identity(1,1) Primary Key,
  CodigoVenda Int Not Null,
  CodigoDoCliente Int Not Null, 
  CodigoDoFuncionario Int Not Null, 
  CodigoDoEntregador Int Not Null,
  CodigoDoProduto Int Not Null, 
  TimeID Int Not Null,
  Itens TinyInt,
  Valor Numeric(4,2),
  Contador TinyInt)
Go

-- Passo 3 - Criando e Populando dados nas Dimensões --

-- Criando a Tabela Calendario --
Create Table Calendario
 (CodigoCalendario Int Identity(1,1) Primary Key Clustered,
  DataCalendario DateTime)
Go

-- Inserindo 10000 linhas de registros lógicos na Tabela Calendario --
Declare @Contador Int

Set @Contador=1

While @Contador <=10000
 Begin

  Insert Into Calendario Values (GetDate()+@Contador)

  Set @Contador = @Contador+1

 End

 -- Consultando --
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

-- Populando as Datas com base na Tabela Calendario na DimTime --
Insert Into DimTime ([Dia], [DiaDaSemana], [DiaDaSemanaPorExtenso], [DiaDoMes], [DiaNoAno], [Semana], [SemanaNoMes], [SemanaNoAno], [PrimerioDiaDaSemana], [UltimoDiaDaSemana], [Mes], [MesPorExtenso], [Quartil], [MesQuartil], [QuartilPorExtenso], [Ano], [AnoPorExtenso], [DataAtual], [HoraAtual], [DataHora], [Horas], [Minutos], [Segundos], [FeriadoPorExtenso])
Select Day(DataCalendario) As Dia,
       DATEPART(DW, DataCalendario) As DiaDaSemana,
	   Case DATEPART(DW, DataCalendario)
	    When 1 Then 'Segunda-Feira'
		When 2 Then 'Terça-Feira'
		When 3 Then 'Quarta-Feira'
		When 4 Then 'Quinta-Feira'
		When 5 Then 'Sexta-Feira'
		When 6 Then 'Sábado'
		When 7 Then 'Domingo'
	   End As DiaDaSemanaPorExtenso,
	   DATEPART(D, DataCalendario) As DiaDoMes,
	   DATEPART(DAYOFYEAR, DataCalendario) As DiaDoAno,
	   DatePart(WEEK, DataCalendario) As Semana,
	   Datepart(Day, Datediff(day, 0, DataCalendario)/7 * 7)/7 + 1 As SemanaNoMes,
	   DatePart(WEEK, DataCalendario) As SemanaNoAno,
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
	    When DatePart(Q, DataCalendario) = 1 And MONTH(DataCalendario) = 1 Then 1
		When DatePart(Q, DataCalendario) = 1 And MONTH(DataCalendario) = 2 Then 2
		When DatePart(Q, DataCalendario) = 1 And MONTH(DataCalendario) = 3 Then 3
		When DatePart(Q, DataCalendario) = 2 And MONTH(DataCalendario) = 4 Then 4
		When DatePart(Q, DataCalendario) = 2 And MONTH(DataCalendario) = 5 Then 1
		When DatePart(Q, DataCalendario) = 2 And MONTH(DataCalendario) = 6 Then 2
		When DatePart(Q, DataCalendario) = 3 And MONTH(DataCalendario) = 7 Then 3
		When DatePart(Q, DataCalendario) = 3 And MONTH(DataCalendario) = 8 Then 4
		When DatePart(Q, DataCalendario) = 3 And MONTH(DataCalendario) = 9 Then 1
		When DatePart(Q, DataCalendario) = 4 And MONTH(DataCalendario) = 10 Then 2
		When DatePart(Q, DataCalendario) = 4 And MONTH(DataCalendario) = 11 Then 3
		When DatePart(Q, DataCalendario) = 4 And MONTH(DataCalendario) = 12 Then 4
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
	   DATEPART(HOUR, DataCalendario) As Horas,
	   DATEPART(MINUTE, DataCalendario) As Minutos,
	   DATEPART(MINUTE, DataCalendario) As Segundos,
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

-- Criando a Dimensao Produto - DimProduto --
Create Table DimProduto
 (CodigoDoProduto Int Identity(1,1) Primary Key Clustered,
  NumeroIdentificacao Int Not Null,
  CodigoDeBarras Int Not Null,
  Descricao Varchar(50) Not Null,
  Apelido Varchar(20) Not Null,
  Sigla Char(3) Default 'PRO',
  Peso Float Not Null,
  Quantidade Int Not Null,
  DataCadastro DateTime Default GetDate(),
  AnoCadastro As Year(DataCadastro),
  MesCadastro As Month(DataCadastro),
  DiaCadastro As Day(DataCadastro),
  DataFabricacao Date Not Null)
Go

-- Populando os dados na Dimensao Produto - DimProduto --
Declare @ContadorDeLinhas SmallInt

Set @ContadorDeLinhas = 1

While @ContadorDeLinhas <= 20000
 Begin
  
  Insert Into DimProduto (NumeroIdentificacao, CodigoDeBarras, Descricao, Apelido, Peso, Quantidade, DataFabricacao)
  Values(Rand()*10000+@ContadorDeLinhas, '78962431'+Rand()*789, Concat('Produto ',@ContadorDeLinhas), Char(Rand()*255), Rand()*100+1, Rand()*100+2, DateAdd(D,Rand()*365+1,GetDate()))

  Set @ContadorDeLinhas = @ContadorDeLinhas+1
End

-- Consultando --
Select * From DimProduto
Go

-- Criando a Dimensao Cliente - DimCliente --
Create Table DimCliente
 (CodigoDoCliente Int Identity(1,1) Primary Key Clustered,
   CPF Int Not Null,
   RG Int Not Null,
   Nome Varchar(80) Not Null,
   Apelido Varchar(20) Not Null,
   DataNascimento Date Not Null,
   AnoNascimento As Year(DataNascimento),
   MesNascimento As Month(DataNascimento),
   DiaNascimeto As Day(DataNascimento),
   Endereco Varchar(200),
   Estado Varchar(50),
   Municipio Varchar(100),
   Salario Numeric(6,2))
Go

-- Populando os dados na Dimensao Cliente - DimCliente --
Declare @ContadorDeLinhas Int

Set @ContadorDeLinhas = 1

While @ContadorDeLinhas <= 40000
 Begin
  
  Insert Into DimCliente (CPF, RG, Nome, Apelido, DataNascimento, Endereco, Estado, Municipio, Salario)
  Values(Rand()*1000000, Rand()*2000000, Concat('Cliente ',@ContadorDeLinhas), Char(Rand()*96),
               GetDate()-Rand()*6570,
			   Concat('Endereço - ',@ContadorDeLinhas,', ',Char(Rand()*255),Char(Rand()*255),Char(Rand()*255)), 
			   'São Paulo',
			   Concat('Municipio ',Char(Rand()*65),Char(Rand()*96)),
			   Rand()*9999)

  Set @ContadorDeLinhas = @ContadorDeLinhas+1
End

-- Consultando --
Select * From DimCliente
Go

-- Criando a Dimensao Funcionario - DimFuncionario --
Create Table DimFuncionario
 (CodigoDoFuncionario Int Identity(1,1) Primary Key Clustered,
   CPF Int Not Null,
   RG Int Not Null,
   Nome Varchar(80) Not Null,
   DataNascimento Date Not Null,
   AnoNascimento As Year(DataNascimento),
   MesNascimento As Month(DataNascimento),
   DiaNascimeto As Day(DataNascimento),
   Endereco Varchar(200),
   Estado Varchar(50),
   Municipio Varchar(100),
   Salario Numeric(6,2))
Go

-- Populando os dados na Dimensao Funcionario - DimFuncionario --
Declare @ContadorDeLinhas SmallInt

Set @ContadorDeLinhas = 1

While @ContadorDeLinhas <= 500
 Begin
  
  Insert Into DimFuncionario(CPF, RG, Nome, DataNascimento, Endereco, Estado, Municipio, Salario)
  Values(Rand()*1000000, Rand()*2000000, Concat('Funcionario ',Char(Rand()*255),Char(Rand()*255),Char(Rand()*255)), 
               GetDate()-Rand()*6570,
			   Concat('Endereço - ',@ContadorDeLinhas,', ',Char(Rand()*255),Char(Rand()*255),Char(Rand()*255)), 
			   'São Paulo',
			   Concat('Municipio ',Char(Rand()*65),Char(Rand()*96)),
			   Rand()*9999)

  Set @ContadorDeLinhas = @ContadorDeLinhas+1
End

-- Consultando --
Select * From DimFuncionario
Go

-- Criando a Dimensao Entregador - DimEntregador --
Create Table DimEntregador
 (CodigoDoEntregador Int Identity(1,1) Primary Key Clustered,
   CPF Int Not Null,
   Nome Varchar(80) Not Null,
   DataNascimento Date Not Null,
   Endereco Varchar(200),
   Estado Varchar(50),
   Municipio Varchar(100))
Go

-- Populando os dados na Dimensao Entregador - DimEntregador --
Declare @ContadorDeLinhas SmallInt

Set @ContadorDeLinhas = 1

While @ContadorDeLinhas <= 50
 Begin
  
  Insert Into DimEntregador(CPF, Nome, DataNascimento, Endereco, Estado, Municipio)
  Values(Rand()*1000000, Concat('Entregador ',@ContadorDeLinhas), 
               GetDate()-Rand()*6570,
			   Concat('Endereço - ',@ContadorDeLinhas), 
			   'São Paulo',
			   Concat('Municipio - ',@ContadorDeLinhas))

  Set @ContadorDeLinhas = @ContadorDeLinhas+1
End

-- Consultando --
Select * From DimEntregador
Go

-- Passo 4 - Criando a Tabela FatoVendas e seus respectivos relacionamentos --
-- Criando a Tabela FatoVendas e Estabelecendo a Métrica SomaMetricaQuantidadeVendas --
Create Table FatoVendas
 (CodigoFato Int Identity(1,1) Primary Key,
  CodigoDoCliente Int Not Null, 
  CodigoDoFuncionario Int Not Null, 
  CodigoDoEntregador Int Not Null,
  CodigoDoProduto Int Not Null, 
  TimeID Int Not Null,
  MetricaSomaItens Int Not Null,
  MetricaSomaValor Numeric(10,2) Not Null,
  MetricaSomaValorPorItem As (MetricaSomaItens / MetricaSomaValor),
  MetricaContadorDeVendas Int)
Go

-- Relacionamentos entre as Dimensões e a Tabela FatoVendas --
Alter Table FatoVendas
 Add Constraint FK_FatoVendas_DimTime_TimeId Foreign Key (TimeID)
  References DimTime(TimeID)
Go

Alter Table FatoVendas
 Add Constraint FK_FatoVendas_DimProduto_CodigoDoProduto Foreign Key (CodigoDoProduto)
  References DimProduto(CodigoDoProduto)
Go

Alter Table FatoVendas
 Add Constraint FK_FatoVendas_DimFuncionario_CodigoDoFuncionario Foreign Key (CodigoDoFuncionario)
  References DimFuncionario(CodigoDoFuncionario)
Go

Alter Table FatoVendas
 Add Constraint FK_FatoVendas_DimCliente_CodigoDoCliente Foreign Key (CodigoDoCliente)
  References DimCliente(CodigoDoCliente)
Go

Alter Table FatoVendas
 Add Constraint FK_FatoVendas_DimEntregador_CodigoDoEntregador Foreign Key (CodigoDoEntregador)
  References DimEntregador(CodigoDoEntregador)
Go





-- Acessando --
Use TopicosAula07
Go

-- Passo 5 - Iniciando o processo de carga de dados -- Realizando simulações de Vendas --
-- Declarando as variáveis de controle --
Declare @CodigoDoCliente Int, @CodigoDoFuncionario Int, @CodigoDoEntregador Int, @CodigoDoProduto Int, @TimeID Int, @Simulacoes BigInt

-- Definindo o número inicial de simulações de vendas --
Set @Simulacoes = 1

-- Processando as simulações de Vendas --
While @Simulacoes <=Rand()*1000000
Begin

 -- Selecionando de forma aleatório os valores para as variáveis de controle --
 Set @CodigoDoCliente = Rand()*40000
 Set @CodigoDoFuncionario = Rand()*500
 Set @CodigoDoEntregador = Rand()*50
 Set @CodigoDoProduto = Rand()*20000
 Set @TimeID = Rand()*10000
 
 Insert Into Vendas (CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, Itens, Valor, Contador)
 Select C.CodigoDoCliente, F.CodigoDoFuncionario, E.CodigoDoEntregador, P.CodigoDoProduto, T.TimeID, Rand()*255, Rand()*99.99, 1
 From DimCliente C, DimFuncionario F, DimEntregador E, DimProduto P, DimTime T
 Where C.CodigoDoCliente = @CodigoDoCliente
 And F.CodigoDoFuncionario = @CodigoDoFuncionario
 And E.CodigoDoEntregador = @CodigoDoEntregador
 And P.CodigoDoProduto = @CodigoDoProduto
 And T.TimeID = @TimeID

 Set @Simulacoes = @Simulacoes + 1
End

-- Exibindo o total de simulações realizadas --
Select @Simulacoes As 'Simulações processadas'
Go

-- Consultando --
Select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, 
           Itens, Valor, Contador
From Vendas
Order By CodigoDoCliente
Go