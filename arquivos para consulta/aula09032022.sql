--Criando o banco de dados--
create database Aula02

--conectando ao banco--

use Aula02


--criando a minha primeira Tabela chamada Produtos--

create table Produtos
(CodigoDoProduto int Not Null, --n�o aceita nulos--
DescricaoDoProduto varchar(20) Not Null,
SiglaDoProduto char(2) Null, --aceita nulos--
DataDeCadastroDoProduto DateTime null)
go



create table Usuarios
(CodigoUsuario int Primary Key, --chave primaria--
NomeUsuario Varchar(100) Not Null,
EnderecoUsuario varchar(155) not null,
loginUsuario varbinary (10) not null,
DataCadastroUsuario Date null)
go

--consultando a estrutura da Tabela de Usuarios, exibindo todas as colunas --
select * from Usuarios --metodo pregui�oso, devemos evitar o uso do asterisco, uma vez que ele tras todos os dados do banco--
go

--de preferencia usar esta forma, declarando, informando o nome das colunas a serem utilizadas--
select CodigoUsuario, NomeUsuario, LoginUsuario, DataCadastroUsuario
from Usuarios
go


--inserindo um novo registro l�gico na tabela de Usuarios--

insert into Usuarios(CodigoUsuario, NomeUsuario, EnderecoUsuario, DataCadastroUsuario, loginUsuario)
values(1, 'Lero Lero', 'Rua A','09/03/2022',2022) --Rela��o de valores a serem armazenados em cada coluna declara acima
go

select CodigoUsuario, NomeUsuario, LoginUsuario, DataCadastroUsuario
from Usuarios
go


insert into Usuarios(CodigoUsuario, NomeUsuario, EnderecoUsuario, DataCadastroUsuario, loginUsuario)
values(2, 'Pedro', 'Rua b','09/03/2022',2022) --Rela��o de valores a serem armazenados em cada coluna declara acima
go


--comando para inserir colunas
alter table Usuarios add UserUsuario varchar(10)



insert into Usuarios(CodigoUsuario, NomeUsuario, EnderecoUsuario, DataCadastroUsuario, UserUsuario, loginUsuario)
values(3, 'Mal�', 'Rua c','09/03/2022','Mal�',2022) --Rela��o de valores a serem armazenados em cada coluna declara acima
go



select CodigoUsuario, NomeUsuario, LoginUsuario, DataCadastroUsuario, UserUsuario
from Usuarios
go



--criando a tabela de cliente--
create table Clientes
(CodigoDoCliente int Not Null Primary Key Identity(1,1), -- chave prim�ria artifficial, autonumerada--
NomeDoCliente varchar(80) not null, 
SexoDoCliente varchar(1) Not Null, 
HoraNascimento time,
EstadoCivil varchar(20))
go


--apresentando as colunas da tabela de clientes com novos r�tulos ou apelidos--
select CodigoDoCliente as 'C�digo',
NomeDoCliente as 'Nome',
SexoDoCliente as 'Sexo',
HoraNascimento as 'HoraNascimento',
EstadoCivil 'Loucura'
from Clientes
go

--inserindo com os nomes das colunas
insert into Clientes(NomeDoCliente, SexoDoCliente, HoraNascimento, EstadoCivil)
values('Pedro', 'M','10:00','Casado') 
go


--inserindo sem o nome das colunas
insert into Clientes values('Jo�o Pedro', 'M','11:25:00','Solteiro') 
go

select CodigoDoCliente, NomeDoCliente, SexoDoCliente, HoraNascimento, EstadoCivil from Clientes

--vamos entender a importancia da cl�usula where = onde--
Select NomeDoCliente, EstadoCivil from Clientes 
where CodigoDoCliente = 1 --filtro condicional--
go

--vamos entender a importancia da cl�usula where = onde--
Select NomeDoCliente, EstadoCivil, HoraNascimento from Clientes 
where NomeDoCliente <> ('Pedro') --filtro condicional--
go


Select NomeDoCliente, EstadoCivil, HoraNascimento from Clientes 
where NomeDoCliente ='Pedro' 
or NomeDoCliente <> 'Jo�o Pedro' --filtro condicional
go


--atualizando uma linha de registro l�gico
update Clientes
set NomeDoCliente = 'Maria Luiza', EstadoCivil='mimada'
where CodigoDoCliente = 2
go


--removendo ou excluindo uma linha de registro
delete from Clientes
where CodigoDoCliente = 1
go


--removendo todos os dados e reconstruindo a estrutura da tabela--
truncate table Clientes --com esse comando n�o � possivel recuperar os dados caso n�o tenha backup--
go

--criando uma copia da tabela de clientes utilizando a t�cnica Select Into--
select*into MinhaNovaTabelaDeClientes from Clientes
go

select*from MinhaNovaTabelaDeClientes
go


--simulando a manipula��o de transa��es
begin transaction -- abrir a transa��o--

delete from Clientes

commit Transaction --confirma��o

rollback transaction --desfazendo desde o begin trasaction


----------------
select * from Clientes