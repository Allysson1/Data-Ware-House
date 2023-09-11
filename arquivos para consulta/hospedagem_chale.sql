create database Hotel 
go

use Hotel
go

/*Criando as tabelas*/

create table Hospedagem
(CodHospedagem int primary key not null,
CodChale int not null,
Estado char(2) not null,
DataInicio dateTime not null,
DataFim dateTime not null,
QtdPessoas int not null,
Desconto decimal(6,2) not null,
ValorFinal decimal (6,2))
go /*executado*/


create table Cliente
(CodCliente int primary key not null,
NomeCliente varchar(255) not null,
RgCliente int not null,
EnderecoCliente varchar(255) not null,
BairroCliente varchar(255) not null,
CidadeCliente varchar(255) not null,
EstadoCliente char(2) not null,
CepCliente int not null,
NascimentoCliente dateTime not null)
go /*executado*/


create table Telefone 
(Telefone Int primary key not null,
CodCliente int not null,
TipoTelefone varchar(20) not null)  
go  /*executado*/


create table Chale 
(CodChale int primary key not null,
Localizacao varchar(255) not null,
Capacidade int not null,
ValorAltaEstacao decimal(6,2) not null,
ValorBaixaEstacao decimal(6,2) not null)
go  /*executado*/


create table Item
(NomeItem varchar(100) primary key not null,
DescricaoItem varchar(255) not null)
go /*executado*/



create table Chale_Item
(CodChale int not null,
NomeItem varchar(100) not null)
go /*executado*/



create table Hospedagem_Servico
(DataSevico datetime primary key not null,
CodHospedagem int not null,
CodServico int not null,
ValorServico decimal(6,2) not null)
go /*executado*/


create table Servico
(CodServico int primary key not null,
NomeServico varchar(50) not null,
ValorServico decimal(6,2) not null)
go /*executado*/







/*Iniciando os relacionamentos*/

alter table Hospedagem
add constraint FK_Hospedagem_Chale_CodChale foreign key (CodChale)
references Chale(CodChale)
go/*executado*/


alter table Chale_Item 
add constraint FK_ChaleItem_Chale_CodCliente foreign key (CodChale)
references Chale(CodChale)
go/*executado*/


alter table Chale_Item 
add constraint FK_ChaleItem_Item_nomeItem foreign key (NomeItem)
references Item(NomeItem)
go/*executado*/


alter table Telefone
add constraint Fk_Telefone_Cliente_CodCliente foreign key (CodCliente)
references Cliente(CodCliente)
go/*executado*/



alter table Hospedagem_Servico
add constraint FK_HospedagemServico_Hospedagem_CodHospedagem foreign key (CodHospedagem)
references Hospedagem(CodHospedagem)
go/*executado*/


alter table Hospedagem_Servico
add constraint FK_HospedagemServico_Servico_CodServico foreign key (CodServico)
references Servico(CodServico)
go/*executado*/