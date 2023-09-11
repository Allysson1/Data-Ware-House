create database Juncoes
go

use Juncoes
go

--conex�o de duas tabelas sem chave estrangeira � do tipo de relacionamento l�gico--

--criando uma jun��o de tabelas --operador inner join--
create table TabelaDireita
(Codigo int primary key,
Descricao char(10) default 'Direira',
Valor tinyint Default 10)
go

create table TabelaEsquerda
(Codigo int primary key,
Descricao char(10) default 'Esquerda',
Valor tinyint Default 20)
go

insert into TabelaDireita (Codigo) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)

insert into TabelaEsquerda (Codigo) values (1),(2),(3),(4),(5),(6),(7),(8),(9),(10)
go


--consultando os dados em cada tabela--
select Codigo, Descricao, Valor from TabelaDireita
go

select Codigo, Descricao, Valor from TabelaEsquerda
go


--realizando a jun��o entre tabelas -- TabelaDireita e TabelaEsquerda atrav�s do operador INNER join (AND)--
select E.Descricao as 'Descri��o da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'C�digo da Direita'
from TabelaEsquerda E inner Join TabelaDireita D  --define o operador da jun��o-- sempre a tabela que estiver antes do inner join ser� a tabela da esquerda e a tabela que estiver depois do inner join ser� a tabela da direita, isso � PADR�O
								on E.Codigo = D.Codigo -- Defini��o da condi��o aplicada para a Jun��o
order by E.Descricao
go








--realizando a jun��o entre tabelas -- TabelaDireita e TabelaEsquerda atrav�s do operador LEFT join (O)--
select E.Codigo as 'C�digo da Esquerda',
        E.Descricao as 'Descri��o da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'C�digo da Direita'
from TabelaEsquerda E left Join TabelaDireita D  --define o operador da jun��o-- sempre a tabela que estiver antes do inner join ser� a tabela da esquerda e a tabela que estiver depois do inner join ser� a tabela da direita, isso � PADR�O
								on E.Codigo = D.Codigo -- Defini��o da condi��o aplicada para a Jun��o
order by E.Descricao
go


--m�todo para n�o aparecer nulos
select E.Codigo as 'C�digo da Esquerda',
        E.Descricao as 'Descri��o da Esquerda',
		isNull(D.Valor,0) as 'Valor da direita',
		isnull(D.Codigo,0) as 'C�digo da Direita'
from TabelaEsquerda E left Join TabelaDireita D  --define o operador da jun��o-- sempre a tabela que estiver antes do join ser� a tabela da esquerda e a tabela que estiver depois do inner join ser� a tabela da direita, isso � PADR�O
								on E.Codigo = D.Codigo -- Defini��o da condi��o aplicada para a Jun��o
order by E.Descricao
go






--inserindo dados na TabelaDireita
insert into TabelaDireita (Codigo) values (110),(120),(130),(140),(150),(160),(170),(180),(190),(200)
go

--realizando a jun��o entre tabelas -- TabelaDireita e TabelaEsquerda atrav�s do operador LEFT join (OR)--
select E.Codigo as 'C�digo da Esquerda',
        E.Descricao as 'Descri��o da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'C�digo da Direita'
from TabelaEsquerda E right Join TabelaDireita D  --define o operador da jun��o-- sempre a tabela que estiver antes do inner join ser� a tabela da esquerda e a tabela que estiver depois do inner join ser� a tabela da direita, isso � PADR�O
								on E.Codigo = D.Codigo -- Defini��o da condi��o aplicada para a Jun��o
order by E.Descricao
go




--criando a tabela de funcion�rios --todo funcion�rio vai ter 1 dependente--
create table Funcionario
(CodigoFuncionario int identity(1,2) primary key,
NomeFuncionario varchar(60) not null)
go


create table Dependente
(CodigoDependente int identity(1,2) primary key,
CodigoFuncionario int not null,
NomeDependente varchar(60))
go


--estabelecendo o relacionamento--
alter table Dependente
add constraint FK_Dependente_Funcionario_CodigoFuncionario foreign key (CodigoFuncionario)
References Funcionario (CodigoFuncionario)
go