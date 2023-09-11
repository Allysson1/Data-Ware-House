create database Empresa
go

use Empresa
go

create table Departamento
(CodigoDepartamento int not null primary key identity(1,1),
NomeDepartamento varchar(60) not null)
go


create Table Cargo
(CodigoCargo int not null primary key identity(1,1),
DescricaoCargo varchar(80) not null)
go

Create Table Empregado
(CodigoEmpregado int not null primary key identity(1,1),
CodigoDepartamento int null,
CodigoCargo int null,
NomeEmpregado varchar(100) not null,
SalarioEmpregado float not null)
go




insert into Departamento (NomeDepartamento) 
values ('RH'),
		('TI'),
		('Produção'),
		('Logistica'),
		('Diretoria'),
		('Almoxarifado')
go

insert into Cargo (DescricaoCargo)
values ('Gerente'),
		('Encarregado'),
		('Auxiliar'),
		('Estagiário')
go

insert into Empregado (NomeEmpregado, SalarioEmpregado, CodigoCargo, CodigoDepartamento)
values ('Allysson', 1000 , 4, 2),
		('João', 1200, 3, 6),
		('Marcus', 3000, 1, 4),
		('Bill', 5000, 2, 1),
		('Luan', 2000, 4, 3),
		('Maria', 1400, 2, null),
		('Marcia', 3400, 1, null),
		('Murilo', 1700, 3, 3),
		('Alana', 5600, 2, 1),
		('Maria Joaquina', 5400, 1, 5),
		('Cicilia', 8000, 3, 5),
		('Lucina', 4652, 2, 5),
		('Cirilo', 1486, 4, 4)
go



alter table Empregado
add constraint FK_Departamento_CodigoDepartamento foreign key (CodigoDepartamento)
references Departamento(CodigoDepartamento)
go


alter table Empregado
add constraint FK_Cargo_CodigoCargo foreign key(CodigoCargo)
references Cargo(CodigoCargo)
go




--1. Selecione os funcionários por departamento-

select Emp.NomeEmpregado, Dep.NomeDepartamento From Departamento Dep inner join Empregado Emp
				on Emp.CodigoDepartamento = Dep.CodigoDepartamento
order by Dep.CodigoDepartamento asc
go


--2.Selecione os funcionários e seu departamento cujo salário é 
--maior que R$1.200,00.--

select dep.NomeDepartamento, Emp.NomeEmpregado, Emp.SalarioEmpregado From Departamento Dep inner join Empregado Emp 
				on Emp.SalarioEmpregado > 1200
order by Dep.CodigoDepartamento asc
go


--3.	Selecione a média dos salários por departamentos.--

select 
avg(emp.SalarioEmpregado) as 'Média de salários',
dep.NomeDepartamento as 'Nome do Departamento'
From Empregado emp inner join Departamento dep 
on dep.CodigoDepartamento = emp.CodigoDepartamento
group by dep.NomeDepartamento
go


--4.Selecione o departamento que tem o maior salário médio.--
select 
avg(emp.SalarioEmpregado) as 'Média de salários',
dep.NomeDepartamento as 'Nome do Departamento'
From Empregado emp inner join Departamento dep 
on dep.CodigoDepartamento = emp.CodigoDepartamento
group by dep.NomeDepartamento
order by dep.NomeDepartamento
offset 1 row  -- Estabelece o novo conjunto de linhas ou posição inicial
fetch next 1 rows only --determina a quantidade de linhas retornadas em tela logo após posição inicial definina
go


--5.	Selecione a média dos salários dos departamentos em que a média dos salários é maior que R$1200,00.
select 
avg(emp.SalarioEmpregado) as 'Média de salários',
dep.NomeDepartamento as 'Nome do Departamento'
From Empregado emp inner join Departamento dep 
on dep.CodigoDepartamento = emp.CodigoDepartamento
group by dep.NomeDepartamento
having avg(emp.SalarioEmpregado) > 1200 -- clausula Having tem o objetivo de ser igual a um where em funções agregadas
order by dep.NomeDepartamento asc
go

--6.	Quais tipos de empregados estão presentes em mais de um departamentos? corrigir
select NomeEmpregado, CodigoDepartamento from Empregado
where CodigoDepartamento in (select CodigoDepartamento from Departamento)
go



--7.	Que tipos de empregados não possuem departamentos? corrigir
select emp.NomeEmpregado, CodigoDepartamento
from Empregado emp 
where CodigoDepartamento is null
order by emp.NomeEmpregado
go

--8.	Selecione a média dos salários por tipo de empregado e por departamento.
select 
avg(emp.SalarioEmpregado) as 'Média de salários',
dep.NomeDepartamento as 'Nome do Departamento'
From Empregado emp inner join Departamento dep 
on dep.CodigoDepartamento = emp.CodigoDepartamento
group by dep.NomeDepartamento

order by dep.NomeDepartamento asc
go


--9.	Selecione o total de funcionários por departamento e por tipo de empregado(cargo).
select 
COUNT(dep.CodigoDepartamento) as 'total do departamento', dep.CodigoDepartamento,
car.CodigoCargo as 'funcionarios/cargo'
From Cargo car inner join Departamento dep
on dep.CodigoDepartamento = car.CodigoCargo
inner join Empregado emp on dep.CodigoDepartamento = emp.CodigoDepartamento
group by car.CodigoCargo, dep.CodigoDepartamento
go


--10.	Selecione o total de funcionários por departamento, salário e tipo de empregado, para aqueles funcionários com salário >= R$ 1000,00.  --corrrigir
select 
COUNT(dep.CodigoDepartamento) as 'total do departamento',
COUNT(car.CodigoCargo) as 'total de funcionarios por cargo',
emp.NomeEmpregado,
emp.SalarioEmpregado
From Cargo car inner join Departamento dep
on dep.CodigoDepartamento = car.CodigoCargo
inner join Empregado emp on dep.CodigoDepartamento = emp.CodigoDepartamento
group by emp.NomeEmpregado, dep.CodigoDepartamento, emp.SalarioEmpregado
having(emp.SalarioEmpregado >= 1000)
order by dep.CodigoDepartamento asc
go


--11.	Selecione o total de funcionários por departamento, com a média do salário do departamento, se o total de funcionários > 1. --corrigir
select 
COUNT(dep.CodigoDepartamento) as 'total do departamento',
COUNT(car.CodigoCargo) as 'total de funcionarios por cargo',
avg(emp.SalarioEmpregado) as 'Média de salários',
emp.NomeEmpregado,
emp.SalarioEmpregado
From Cargo car inner join Departamento dep
on dep.CodigoDepartamento = car.CodigoCargo
inner join Empregado emp on dep.CodigoDepartamento = emp.CodigoDepartamento
group by emp.NomeEmpregado, dep.CodigoDepartamento, emp.SalarioEmpregado
having(car.CodigoCargo > 1)
order by dep.CodigoDepartamento asc
go

--12.Selecione o total de funcionários por departamento e por tipo de empregado no departamento, se o total de funcionários > 1. --corrigir

select 
emp.NomeEmpregado,
emp.SalarioEmpregado
From Cargo car inner join Departamento dep
on dep.CodigoDepartamento = car.CodigoCargo
inner join Empregado emp on dep.CodigoDepartamento = emp.CodigoDepartamento
group by emp.NomeEmpregado, dep.CodigoDepartamento, emp.SalarioEmpregado
having(dep.CodigoDepartamento > 1)
order by dep.CodigoDepartamento asc
go
