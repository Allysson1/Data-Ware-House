create database Juncoes
go

use Juncoes
go

--conexão de duas tabelas sem chave estrangeira é do tipo de relacionamento lógico--

--criando uma junção de tabelas --operador inner join--
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


--realizando a junção entre tabelas -- TabelaDireita e TabelaEsquerda através do operador INNER join (AND)--
select E.Descricao as 'Descrição da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'Código da Direita'
from TabelaEsquerda E inner Join TabelaDireita D  --define o operador da junção-- sempre a tabela que estiver antes do inner join será a tabela da esquerda e a tabela que estiver depois do inner join será a tabela da direita, isso é PADRÃO
								on E.Codigo = D.Codigo -- Definição da condição aplicada para a Junção
order by E.Descricao
go








--realizando a junção entre tabelas -- TabelaDireita e TabelaEsquerda através do operador LEFT join (O)--
select E.Codigo as 'Código da Esquerda',
        E.Descricao as 'Descrição da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'Código da Direita'
from TabelaEsquerda E left Join TabelaDireita D  --define o operador da junção-- sempre a tabela que estiver antes do inner join será a tabela da esquerda e a tabela que estiver depois do inner join será a tabela da direita, isso é PADRÃO
								on E.Codigo = D.Codigo -- Definição da condição aplicada para a Junção
order by E.Descricao
go


--método para não aparecer nulos
select E.Codigo as 'Código da Esquerda',
        E.Descricao as 'Descrição da Esquerda',
		isNull(D.Valor,0) as 'Valor da direita',
		isnull(D.Codigo,0) as 'Código da Direita'
from TabelaEsquerda E left Join TabelaDireita D  --define o operador da junção-- sempre a tabela que estiver antes do join será a tabela da esquerda e a tabela que estiver depois do inner join será a tabela da direita, isso é PADRÃO
								on E.Codigo = D.Codigo -- Definição da condição aplicada para a Junção
order by E.Descricao
go






--inserindo dados na TabelaDireita
insert into TabelaDireita (Codigo) values (110),(120),(130),(140),(150),(160),(170),(180),(190),(200)
go

--realizando a junção entre tabelas -- TabelaDireita e TabelaEsquerda através do operador LEFT join (OR)--
select E.Codigo as 'Código da Esquerda',
        E.Descricao as 'Descrição da Esquerda',
		D.Valor as 'Valor da direita',
		D.Codigo as 'Código da Direita'
from TabelaEsquerda E right Join TabelaDireita D  --define o operador da junção-- sempre a tabela que estiver antes do inner join será a tabela da esquerda e a tabela que estiver depois do inner join será a tabela da direita, isso é PADRÃO
								on E.Codigo = D.Codigo -- Definição da condição aplicada para a Junção
order by E.Descricao
go




--criando a tabela de funcionários --todo funcionário vai ter 1 dependente--
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