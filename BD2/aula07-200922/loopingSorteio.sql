create database Looping
go

use Looping
go


Create table NumerosSorteados
(Numero int)
go

--Set Nocount on elimina a contagem de linhas nos 'Resultados' do 'terminal', ou seja, a mensagem '1 linha foi afetada' não aparece mais no código. O comando pode ser executado apenas uma vez para desativar a contagem de linhas, para ativar novamente, se utiliza o comando 'set nocount off'	
set Nocount on
go

--o truncate table elimina os números que já estavam na tabela NumerosSorteados, para que novos números sejam alocado. Este comando deve ser executado junto com os comandos padrões do While (desde o declare até o End;)
truncate table NumerosSorteados
go

Declare @Variavel int, @NumeroSorteado int
Set @Variavel = 0
Set @NumeroSorteado = 0


while @Variavel <=1000
	begin 
		Set @NumeroSorteado = convert(int,Rand()*100)

		print @NumeroSorteado

		if Exists(select Numero from NumerosSorteados where Numero = @NumeroSorteado)
 		Set @NumeroSorteado = convert(int,Rand()*100)
	    Else
			insert into NumerosSorteados values (@NumeroSorteado)
		
		Set @Variavel = @Variavel + 1

end;
go


select * from NumerosSorteados
order by Numero asc



select * from NumerosSorteados
order by Numero desc