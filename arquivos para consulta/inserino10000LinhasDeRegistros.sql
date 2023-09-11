use Empresas
go

--inserindo 200 linhas de registros logicos na tabela de Fornecedores--
--declarando a variavel @ContadorDeLinhas

Declare @ContadorDeLinhas tinyInt

--atribuindo um valor inicial para a variavel @contadordelinhas--
set @ContadorDeLinhas = 1

--Definindo o bloco de execução em loop--
while @ContadorDeLinhas <=200 --condiçao de laço
begin

insert into Fornecedores (NomeFornecedor)
values (CONCAT('FOR',@ContadorDeLinhas))

 set @ContadorDeLinhas = @ContadorDeLinhas + 1--incrementando a contagem de 1 em 1
end
go


--consultando a tabela de fornecedores--
select * from Fornecedores
go


--criando uam tabela para receber valores padroes--
create Table ValoresPadroes
(Codigo int identity(1,1) primary key,
Descricao varchar(20) Default 'Este é um texto',
Valor1 float default 1,
valor2 Numeric(4,2) default 2.00)
go

--inserindo 10000 linhas de registros logicos
insert into ValoresPadroes Default Values
go 10000


--Consultando--Filtrando as 1000 linhas com o comando top--

select Top 1000 * from ValoresPadroes
go