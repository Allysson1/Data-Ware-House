Use TopicosAula07
go


--percorrenco os valores sumarizados através das operações Drill-Down e Roll-Up
--sumulando Drill-Down--
--Exemplo 1 - Quantidade de compras realizadas por CodigoDoCliente --
select CodigoDoCliente, Count(MetricaContadorDeVendas) as QuantidadeDeComprasPorClientes
from FatoVendas
group by CodigoDoCliente
Having COUNT(MetricaContadorDeVendas)>=2
order by QuantidadeDeComprasPorClientes desc
go


--Exemplo 2 - Soma de valores de vendas realizadas com base no CodigoCliente Combinado com o CodigoFuncionario--
select CodigoDoCliente, CodigoDoFuncionario, SUM(MetricaSomaValor) as ValorDaVenda,
		Format(Sum(MetricaSomaValor),'c','pt-br') as ValorDaVendaEmReais --formata o valor para o padrão da moeda Brasileira
from FatoVendas
Group By CodigoDoCliente, CodigoDoFuncionario
Order by CodigoDoCliente
go




--Exemplo 3 - Soma de valores Vendidos por item de acordo com o Cliente + Produto + Time--
select CodigoDoCliente, CodigoDoProduto, TimeID,
		sum(MetricaSomaItens) as QuantidadeDeItensComprados
from FatoVendas
where CodigoDoProduto between 1000 and 3000
group by CodigoDoCliente, CodigoDoProduto, TimeID
Order By CodigoDoCliente, CodigoDoProduto
go



--PEnsar nos demais Niveis -- Descendo para os níveis inferiores -- Decompor--
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID,
		sum(MetricaSomaItens) as QuantidadeDeItensComprados
from FatoVendas
group by CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID
Order By CodigoDoCliente, CodigoDoProduto
go




--Simulando o Roll-Up --
--Exemplo 1 -- Somatória geral de vendas para todos os níveis --
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID,
		sum(MetricaSomaItens) as SomaGeralPorItem,
		AVG(MetricaSomaValor) as SomaGeralPorValor
from FatoVendas
group by CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto, TimeID
order by CodigoDoCliente
go



--Exemplo 2 - Somatoria de vendas por Cliente, Funcionario, Entregador e Produto --
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto,
		Sum(isNull(MetricaContadorDeVendas,1)) as QuantidadeDeVendas
from FatoVendas
group by CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador, CodigoDoProduto
order by CodigoDoProduto desc
go


--Exemplo 3 - Somatória Geral de Produtos por CodigoCliente, CodigoDoFuncionario e CodigoDoEntregador --
select CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador,
		sum(MetricaSomaValor) as SomaGeralPorValor
From FatoVendas
group by CodigoDoCliente, CodigoDoFuncionario, CodigoDoEntregador
order by CodigoDoCliente
go


--exemplo 4 -- Somatoria por CodifoDoFuncionario, CodigoDoProduto -- Metricas Valor e Itens--
select CodigoDoFuncionario, CodigoDoProduto,
		sum(MetricaSomaValor) as SomaGeralDeVEndas,
		sum(MetricaSomaItens) as QuantidadeSomaGeralItens
from FatoVendas
group by CodigoDoFuncionario, CodigoDoProduto
order by CodigoDoFuncionario
go



--Exemplo 5 -- Somatoria Geral por CodigoFuncionario Identificando o Menor Valor e Maior Valor de Vendas--
select CodigoDoFuncionario,
		min(MetricaSomaValor) as MenorValorVEndas,
		sum(MetricaSomaValor) as MaiorValorVEndas
from FatoVendas
group by CodigoDoFuncionario
go


--Exemplo proprio
select CodigoDoProduto,
		Max(MetricaSomaItens) as MaiorQuantidadeGeralDeItens
from FatoVendas
group by CodigoDoProduto
order by CodigoDoProduto
go




--Exemplo 1 -- Apresentando Relatorio Analitico -- Contagem analítica de vendas
select C.CPF, C.Nome, F.Nome, E.CodigoDOEntregador,
		P.Descricao, P.Peso,
		T.DataAtual as Data,
		T.DiaDaSemana,
		COUNT(FV.MetricaContadorDeVendas) as 'Contagem analítica de Vendas'
from FatoVendas FV inner join DimCliente C
			on Fv.CodigoDoCliente = C.CodigoDoCliente
			inner join DimFuncionario F
			on FV.CodigoDoFuncionario = F.CodigoDoFuncionario
			inner join DimEntregador E
			on FV.CodigoDoEntregador = E.CodigoDoEntregador
			inner join DimProduto P
			on FV.CodigoDoProduto = P.CodigoDoProduto
			inner join DimTime T
			on FV.TimeID = T.TimeID
group by C.CPF, C.Nome, F.Nome, E.CodigoDOEntregador,P.Descricao, P.Peso, T.DataAtual,T.DiaDaSemana
go


--Exemplo 2 -- Apresentando o Relatório analítico -- Media De Vendas Por - Cliente, Funcionario, Produto e data
Select C.Nome as Cliente, F.Nome as Funcionario, P.Descricao as Produto, T.DataAtual,
		AVG(MetricaSomaItens) as 'Analise - Media Produtos Vendidos'
from FatoVendas FV inner join DimCliente C
			on Fv.CodigoDoCliente = C.CodigoDoCliente
			inner join DimFuncionario F
			on FV.CodigoDoFuncionario = F.CodigoDoFuncionario
			inner join DimProduto P
			on FV.CodigoDoProduto = P.CodigoDoProduto
			inner join DimTime T
			on FV.TimeID = T.TimeID
where DataAtual Between '08-10-2022' and '31-12-2024'
group by C.Nome, F.Nome, P.Descricao, T.DataAtual
order by DataAtual desc, [Analise - Media Produtos VEndidos] Desc
go