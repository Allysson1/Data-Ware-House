use TopicosAula07
go


-- passo 6 - Populando "Carregando" os dados sumarizados na tabela fatoVendas--
--inserindo dados na tabela através de um select
insert into FatoVendas (CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, MetricaSomaItens, MetricaSomaValor, MetricaContadorDeVendas)
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, Itens, Valor, Contador
from Vendas
order By CodigoDoCliente
go


--consultando a tabela FatoVendas --
select CodigoFato, CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, MetricaSomaItens, MetricaSomaValor, MetricaContadorDeVendas
from FatoVendas
order By CodigoDoCliente
go


--Passo 7 -- Realizando o processamento análitico de dados - aplicando a sumarização de valores na tabela FatoVendas afim de gerar resultados das métricas--
--para a contagem ser executada com sucesso, é preciso fazer antes o passo 7.1, depois voltar no arquivo AulaTopicos7.sql e executar o passo 5, depois o passo 6 novamente, e assim conseguir executar o passo 7, senão os dados continuarão iguais
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID,
	sum(MetricaSomaItens) as SomaGeralDeItens,
	sum(MetricaSomaValor) as SomaGeralDeValores,
	Round(sum(MetricaSomaValorPorItem),2) as SomaGeralDeItensVendidos, --round limita o numero de casas decimais
	sum(MetricaContadorDeVendas) as SomaGeralDeVedasRealizadas
from FatoVendas
group By CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID
order by CodigoDoCliente, CodigoDoFuncionario
go



-- 7.1  Gerando o HistoricoDeVendas --
Insert Into HistoricoVendas (CodigoVenda, CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador,
                                              CodigoDoProduto, TimeID, Itens, Valor, Contador)
Select CodigoVenda, CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID, Itens, Valor, Contador
From Vendas
Order By CodigoVenda
Go



-- Limpando os Dados de Vendas preparando para uma nova simulação --
Truncate Table Vendas
Go


--realizar nova Simulação de vendas


--passo 7.4 -- Realizando a pré_Analise De dados - Tabelda FatoVendas - Contagem de vendas Geral de produtos
select CodigoDoProduto, count(MetricaContadorDeVendas) as SomaGeralDeVendasRealizadas,
	sum(MetricaSomaItens) as SomaGeralDeItens,
	sum(MetricaSomaValor) as SomaGeralDeValores,
	sum(MetricaSomaValorPorItem) as SomaGeralPorItensVendidos
from FatoVendas
group by CodigoDoProduto 
order by SomaGeralDeVendasRealizadas desc
go


--passo 7.5 -- Realizando a pré_Analise De dados - Tabelda FatoVendas - Contagem de vendas Geral por funcionários
select CodigoDoFuncionario, count(TimeID) as ContagemDeVendaPorTime,
	sum(MetricaSomaItens) as SomaGeralDeItens,
	sum(MetricaSomaValor) as SomaGeralDeValores,
	sum(MetricaSomaValorPorItem) as SomaGeralPorItensVendidos
from FatoVendas
group by CodigoDoFuncionario
order by ContagemDeVendaPorTime desc
go
