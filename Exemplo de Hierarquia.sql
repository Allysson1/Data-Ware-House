--Exemplo de Hierarquia--
declare @Data datetime = getdate()

--exemplo de select derivado-- � um select que tr�s o resultado de outros select's
select Nivel, Valor, Descricao
from 
(
Select '1->', Year(@Data) as Ano, 'Ano'
union all
Select '2-->', DATEPART(q, @Data), 'Quartil'
union all
Select '3--->', Month(@Data) as Mes, 'Mes'
union all
Select '4---->', Day(@Data) as Dia, 'Dia'
union all
Select '5----->', DatePArt(HH,@Data),'Horas'
union all
Select '6------>', DatePart(MINUTE,@Data), 'Minutos'
union all
Select '7------->', DatePart(SS,@Data), 'Segundos'
union all
Select '8-------->', DatePart(MILLISECOND,@Data), 'Mil�simos') As Hierarquia (Nivel, VAlor, Descricao)
go