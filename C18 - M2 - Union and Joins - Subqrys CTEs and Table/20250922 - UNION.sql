-- a.	Cree un campo en el que indique si el cliente es solo web, móvil o ambos.
select *, 
 case
 	when A.gender = 'f' then 'FEMENINO'
 	when B.gender = 'f' then 'FEMENINO'
 	when A.gender = 'm' OR B.gender = 'm' then 'MASCULINO'	
 end as genero,
 case
 	when A.codigo is not null and B."Código" is not null then 'AMBOS'
 	when A.codigo is null then 'WEB'
 	when B."Código" is null then 'MOVIL'
 end as tipo 
from bancamovil A 
full outer join bancaweb B on A.codigo = B."Código"


-- b.	¿Todos los usuarios de los clientes son iguales en ambos sistemas?
select *, 
 case
 	when A.gender = 'f' then 'FEMENINO'
 	when B.gender = 'f' then 'FEMENINO'
 	when A.gender = 'm' OR B.gender = 'm' then 'MASCULINO'	
 end as genero,
 case
 	when A.codigo is not null and B."Código" is not null then 'AMBOS'
 	when A.codigo is null then 'WEB'
 	when B."Código" is null then 'MOVIL'
 end as tipo,
 -- USUARIO EN UN SISTEMA
 -- UNIFICADO
 -- DIFERENTES
 case
 	when A.codigo is null or B."Código" is null then 'USUARIO EN UN SISTEMA'
 	when A.user = B.user then 'UNIFICADO'
 	else 'DIFERENTE'
 end
from bancamovil A 
full outer join bancaweb B on A.codigo = B."Código"

-- c.	Cuantos clientes tienen solo Banca Web
-- d.	Cuantos clientes tienen solo Banca Móvil
-- e.	Cuantos clientes cuentan con ambos servicios

-------
select * from bancamovil
where codigo = 'A0007' or codigo = 'A0008' or codigo = 'A0009'

select * from bancamovil
where codigo in ('A0007','A0008','A0009')
-------


-- SUB CONSULTAS

select tipo, count(*)
from (
	select *, 
	 case
	 	when A.gender = 'f' then 'FEMENINO'
	 	when B.gender = 'f' then 'FEMENINO'
	 	when A.gender = 'm' OR B.gender = 'm' then 'MASCULINO'	
	 end as genero,
	 case
	 	when A.codigo is not null and B."Código" is not null then 'AMBOS'
	 	when A.codigo is null then 'WEB'
	 	when B."Código" is null then 'MOVIL'
	 end as tipo,
	 -- USUARIO EN UN SISTEMA
	 -- UNIFICADO
	 -- DIFERENTES
	 case
	 	when A.codigo is null or B."Código" is null then 'USUARIO EN UN SISTEMA'
	 	when A.user = B.user then 'UNIFICADO'
	 	else 'DIFERENTE'
	 end clasificacion
	from bancamovil A 
	full outer join bancaweb B on A.codigo = B."Código"
) A
group by tipo

-- f.	Realice una consulta por genero e indique cuál de los dos tiene más usuarios que poseen ambos servicios. 

select tipo, genero, count(*)
from (
	select *, 
	 case
	 	when A.gender = 'f' then 'FEMENINO'
	 	when B.gender = 'f' then 'FEMENINO'
	 	when A.gender = 'm' OR B.gender = 'm' then 'MASCULINO'	
	 end as genero,
	 case
	 	when A.codigo is not null and B."Código" is not null then 'AMBOS'
	 	when A.codigo is null then 'WEB'
	 	when B."Código" is null then 'MOVIL'
	 end as tipo,
	 -- USUARIO EN UN SISTEMA
	 -- UNIFICADO
	 -- DIFERENTES
	 case
	 	when A.codigo is null or B."Código" is null then 'USUARIO EN UN SISTEMA'
	 	when A.user = B.user then 'UNIFICADO'
	 	else 'DIFERENTE'
	 end
	from bancamovil A 
	full outer join bancaweb B on A.codigo = B."Código"
) A
--where tipo = 'AMBOS'
group by tipo, genero



-- CASE WHEN

-- Presumir un impuesto a los retiros por ATM, Si la transacciones es menor a $100 es excenta, 
-- si es hasta 250 el impuesto es de $1 y el resto con el 10% de la transaccion, Esteimpuesto solo aplica a tarjetas de credito
select *,
	case 
		when tj.tipo = 'DEBITO' or trx.monto < 100 then 0.00
		when tj.tipo = 'CREDITO' and  trx.monto < 250 then 1.00
		else trx.monto * 0.1
	end
from fact_transaccionesatm trx
join dim_tipotarjeta tj on trx.bin = tj.bin


-- Queremos saber si los cajeros automaticos son rentables, 
----  Las farmacias te cobran un renta mensual de 100
---- Las transacciones internacionales te dejan una comision de $5
--- Todos las trx aprobadas te generan un ahorro de $5



--- SUBCONSULTAS
-- select 
-- from
-- where 

-- Necesitamos todas las transacciones realizadas en una farmacia

	--join
	select *
	from fact_transaccionesatm A
	left join dim_terminales B on A.terminal = B.terminal 
	where B.ubicacion = 'FARMACIA'
	-- 2690


	-- Subconsulta

	-- Cajeros en Farmacias
	select terminal from dim_terminales where ubicacion = 'FARMACIA'
	
	
	-- Solucion
	select *
	from fact_transaccionesatm
	where terminal in (select terminal from dim_terminales where ubicacion = 'FARMACIA')
	-- 2690
	
	
	
-- 20250922 JOINS AND UNION

SELECT * FROM bancamovil;
SELECT * FROM bancaweb;


SELECT * FROM bancamovil
union -- UNIENDO REGISTRO QUE SON UNICOS 
SELECT * FROM bancaWEB
-- 210 cliente unicos

SELECT * FROM bancamovil
union all  -- UNIR REGISTROS TOTALES INDEPENDIENTEMENTE SE REPITEN
SELECT * FROM bancaWEB
-- 250 clientes totales
	
	
	
SELECT *, 'MOVIL' as tipo FROM bancamovil
union all
SELECT *, 'WEB' as tipo FROM bancaWEB
