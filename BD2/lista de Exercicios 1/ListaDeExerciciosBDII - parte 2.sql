--utilizando o mesmo banco já criado
use BancoDeDadosIIListaI
go



--criando a tabela de Clientes
create table Clientes
(CodigoCliente int not null identity(1,1) primary key,
NomeCliente varchar(50) not null,
EnderecoCliente varchar(50) not null,
Cidade varchar(20) not null,
UF char(2) default 'SP',
DataNascimento date default getdate(),
CPFCliente bigint not null Unique,
RGCliente bigint not null
)
go

--criando a tabela Fornecedores
create table Fornecedor
(CodFornecedor int not null primary key identity(1,1),
RazaoSocial varchar(80) not null,
CNPJFornecedor bigint not null,
CodigoProduto varchar(200) not null,
DataCadastro dateTime default GetDate(),
Telefone bigint not null)
go


--criando a tabela de produtos
create table Produto
(CodigoProduto int not null primary key identity(1,1),
DescricaoProduto varchar(300) not null,
QuantidadeProduto int not null,
DataValidade date not null,
ValorUnitario float not null,
DataCadastro datetime default getDate())
go
