create database EstiloDaTerra
go

use EstiloDaTerra
go


--AS TABELAS AINDA NÃO FORAM CRIADAS

--criar a tabela produtos para se relacionar com a de vendas e Estoque
--criar a tabela de funcionários para se relacionar com a folha de pagamento, além da tabela de cargos que cada funcionário ocupa

--a tabela de clientes deve conter um Check para data de mascimento de antes de 1920--
--a tabela de cargo deve conter um check para o salário minimo do cliente--

create table Cliente
(CodCliente int not null primary key identity(1,1),
CpfCliente bigint not null,
RgCliente bigint not null,
NomeCliente varchar(200) not null,
DataNascimento date check (DataNAscimento >= '01-01-1920'),
Sexo char(1) check (Sexo = 'F' or Sexo = 'M'),
DataCadastro dateTime default GetDate(),
Telefone bigint not null,
Email varchar(200) not null)
go


--tabela de fornecedores
create table Fornecedor
(CodFornecedor int not null primary key identity(1,1),
CNPJ bigint not null,
NomeFornecedor varchar(200) not null,
DataCadastro dateTime default GetDate(),
Telefone bigint not null,
Email varchar(200) not null)
go



--taabela de funciónários
create table Funcionário
(CodFuncionario int not null primary key identity(1,1),
CodCargo int not null,
CpfFuncionario bigint not null unique,
RgFuncionario bigint not null,
NomeFuncionario varchar(200) not null,
DataNascimento date check (DataNAscimento >= '01-01-2022'),
Sexo char(1) check (Sexo = 'F' or Sexo = 'M'),
Telefone bigint not null,
Email varchar(200) not null)
go


--criando a tabela de cargos
create table Cargo
(CodCargo int not null primary key identity(1,1),
nomeCargo varchar(50) not null,
DescricaoCargo varchar(300) not null,
Salario decimal(7,2) not null check(Salario >= 01212.00))
go



--criando a tabela de folha  de pagamento
create table Folha_Pagamento
(CodFolha_Pagamento int not null primary key identity(1,1),
CodFfuncionario int not null,
codCargo int not null,
DiasTrabalhados int not null,
Atrasos decimal(4,2) not null, --esstá em decimal paara contar as horas e  minutos de atraso no mês
HoraExtra decimal(4,2) not null,
FGTS decimal(7,2) not null,
INSS decimal(7,2) not null)
go 




--o controle de vendas deve conter a data e hora da venda, quantidade de produtos vendidos,  cupom de desconto(null), CodCliente(foreign key)--

create table ControleVenda
(CodVenda int not null primary key identity(1,1),
CodCliente int not null,
CodProduto int not null,
QuantidadeProdutos int not null, --a quantidade de produtos neste caso se refere a quantidade de produtos diversos levados, e não representa a venda de apenas um tipo de produto
CupomDesconto char(10) null,
DataVenda datetime default getdate()) 
go


--criando a tabela de produtos
create table Produto
(CodProduto int not null primary key identity(1,1),
CodVenda int not null,
CodFornecedor int not null,
NomeProduto varchar(200) not null,
DescricaoProduto varchar(300) not null,
QuantidadeEstoque float not null,
DataCadastro datetime default getDate())
go





--estabelecendo as relações


alter table Funcionario
add constraint FK_Cargo_CodCargo foreign key (Codcargo)
references Cargo(CodCargo) 
go



alter table Folha_Pagamento
add constraint FK_Funcionario_CodFuncionario foreign Key (CodFuncionario) 
references Funcionario(CodFuncionario)
go


alter table Folha_Pagamento
add constraint FK_CodCargo foreign Key (CodCargo) 
references cargo(CodCargo)
go


alter table ControleVenda
add constraint FK_Cliente_CodCliente foreign Key (CodCliente) 
references Cliente(CodCliente)
go


alter table ControleVenda
add constraint FK_Produto_CodProduto foreign Key (CodProduto) 
references Produto(CodProduto)
go


alter table Produto
add constraint FK_ControleVEnda_CodVenda foreign Key (CodVenda) 
references ControleVenda(CodVenda)
go



alter table Produto
add constraint FK_Fornecedor_CodFornecedor foreign Key (CodFornecedor) 
references Fornecedor(CodFornecedor)
go