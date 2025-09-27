--20250924
-- Necesitamos un por atm que muestre nombre, terminal, ubicacion y su tipo,  
-- Monto promedio de retiros, 
-- monto prom de depositos 
-- Participacion de nuestras transacciones versus la competencia (No internaciones)

-- Test01
select A.nombre, A.terminal, A.ubicacion, A.tipo , B.MONTO
from dim_terminales A
left join fact_transaccionesatm B on A.terminal = B.terminal
where B.respuesta = 1

-- Test 02
-- Montos retirados por terminal
select terminal, round(avg(monto)) as RETIROS
from fact_transaccionesatm
where respuesta = 1 and trx = 1
group by terminal

-- depositos
select terminal, round(avg(monto)) as DEPOSITOS
from fact_transaccionesatm
where respuesta = 1 and trx = 2
group by terminal

select A.nombre, A.terminal, A.ubicacion, A.tipo, b.retiros, c.depositos
from dim_terminales a
left join (
	select terminal, round(avg(monto)) as RETIROS
	from fact_transaccionesatm
	where respuesta = 1 and trx = 1
	group by terminal
) b on a.terminal = b.terminal
left join (
	select terminal, round(avg(monto)) as DEPOSITOS
	from fact_transaccionesatm
	where respuesta = 1 and trx = 2
	group by terminal
) c on a.terminal = c.terminal 


-- Test03
select A.nombre, A.terminal, A.ubicacion, A.tipo, sum(b.monto) as MONTO_TOTAL,
	round(
		avg(
			case
				when trx =  1 then B.monto
				else null
			end
		)
	) as retiros,
	round(
		avg(
			case
				when trx =  2 then B.monto
				else null
			end
		)
	)
	as depositos
from dim_terminales A
left join fact_transaccionesatm B on A.terminal = B.terminal
left join Participacion C on A.terminal = C.terminal 
where B.respuesta = 1
group by A.nombre, A.terminal, A.ubicacion, A.tipo


--Participacion
-- Sum(monto total) / sum(Monto trx propias)
select 
	TERMINAL, 
	a.monto_propio as entero,
	a.monto_propio::numeric as numerico,
	cast(a.monto_propio as numeric) as numerico_funcion,
	a.monto_total,
	A.monto_propio::numeric/A.monto_total as PARTICIPACION_ENTEROS,
	A.monto_propio::numeric/A.monto_total as PARTICIPACION_CAST
	-- Debido a que monto_propio y monto_total son enteros, su resultado sería un entero.
	-- para mostrar los decimales, tenemos que 'castear' el tipo de dato
	-- :: o CAST() Funcionan iguales
from
(
	select terminal, sum(monto) as MONTO_TOTAL,
		sum(
			case 
				when banco = 'NUESTRO BANCO' then monto
			end
		) as MONTO_PROPIO
	from fact_transaccionesatm X
	join dim_tipotarjeta Y on x.bin = y.bin 
	group by TERMINAL
) a

create temp table Participacion as (
	select 
		TERMINAL, 
		A.monto_propio::numeric/A.monto_total as PARTICIPACION
	from
	(
		select terminal, sum(monto) as MONTO_TOTAL,
			sum(
				case 
					when banco = 'NUESTRO BANCO' then monto
				end
			) as MONTO_PROPIO
		from fact_transaccionesatm X
		join dim_tipotarjeta Y on x.bin = y.bin 
		group by TERMINAL
	) a
)


-- Test04
select A.nombre, A.terminal, A.ubicacion, A.tipo, sum(b.monto) as MONTO_TOTAL,
	round(
		avg(
			case
				when trx =  1 then B.monto
				else null
			end
		)
	) as retiros,
	round(
		avg(
			case
				when trx =  2 then B.monto
				else null
			end
		)
	)
	as depositos,
	min(c.PARTICIPACION)
from dim_terminales A
left join fact_transaccionesatm B on A.terminal = B.terminal
left join Participacion C on A.terminal = C.terminal 
where B.respuesta = 1
group by A.nombre, A.terminal, A.ubicacion, A.tipo




-- Genera la participación de diciembre de 2011, para las tarjetas propias(Nuestro banco), 
-- locales(Tarjetas de otros bancos en tabla de tarjetas) e internacionales (Bin no esta en tabla de tarjetas)

select 
	sum(monto) total, 
	sum(propias) propias, 
	sum(local) local, 
	sum(internacional) internacional,
	sum(propias) + sum(local) + sum(internacional) as validar,
	round((sum(propias::numeric) / sum(monto))*100, 2) as P_propias,
	round((sum(local::numeric) / sum(monto))*100, 2) as P_local,
	round((sum(internacional::numeric) / sum(monto))*100, 2) as P_internacional
from(
	select 
		MONTO,
		case 
			when B.banco = 'NUESTRO BANCO' then MONTO
		end PROPIAS,
		case 
			when B.banco is null then MONTO
		end INTERNACIONAL,
		case 
			when B.banco <> 'NUESTRO BANCO' and B.banco is not null then MONTO
		end LOCAL
	from fact_transaccionesatm A
	left join dim_tipotarjeta B on A.bin = B.bin 
	where A.respuesta = 1 and agno = 2011 and mes = 12
) A


-- Muestrar una tabla de las participaciones de toda la base por mes
select 
	agno, mes,
	round((sum(propias::numeric) / sum(monto))*100, 2) as P_propias,
	round((sum(local::numeric) / sum(monto))*100, 2) as P_local,
	round((sum(internacional::numeric) / sum(monto))*100, 2) as P_internacional
from(
	select 
		agno, mes,
		MONTO,
		case 
			when B.banco = 'NUESTRO BANCO' then MONTO
		end PROPIAS,
		case 
			when B.banco is null then MONTO
		end INTERNACIONAL,
		case 
			when B.banco <> 'NUESTRO BANCO' and B.banco is not null then MONTO
		end LOCAL
	from fact_transaccionesatm A
	left join dim_tipotarjeta B on A.bin = B.bin 
	where A.respuesta = 1
) A
group by agno, mes
order by agno, mes


select 
	monto, 
	monto::numeric, 
	monto::text,
	monto * 0.13,
	monto::numeric * 0.13,
--	monto::text * 0.13 -- esto genera un error por multiplicar un texto
	monto::bool
from fact_transaccionesatm




-- CREACION DE INDEX
select * from fact_transaccionesatm

create index prueba_terminal
on fact_transaccionesatm (terminal)

select * from fact_transaccionesatm
where terminal = 'AT01'



-- EXPLAIN ANALYZE
explain analyze
select * from fact_transaccionesatm




-- Necesitamos el detalle de los atm que transaccionan mas que el promedio de los atm's para diciembre 2010

-- paso1 Vemos el monto de la transaccion por atm
select terminal, sum(monto) as  total
from fact_transaccionesatm
where respuesta = 1 and agno = 2010 and mes = 12
group by terminal
order by SUM(monto) desc

-- paso 2 obtenemos el promedio
select avg(total) as promedio
from (
	select terminal, sum(monto) as  total
	from fact_transaccionesatm
	where respuesta = 1 and agno = 2010 and mes = 12
	group by terminal
) A

-- Opcion uno, ejecutamos con subconsulta en having
select terminal, sum(monto) as  total
from fact_transaccionesatm
where respuesta = 1 and agno = 2010 and mes = 12
group by terminal
having sum(monto) > (
select avg(total) as promedio
	from (
		select terminal, sum(monto) as  total
		from fact_transaccionesatm
		where respuesta = 1 and agno = 2010 and mes = 12
		group by terminal
	) A
)
order by sum(monto)

-- Opcion 2, usamos un CTE
with vars as (
	select avg(total) as promedio
	from (
		select terminal, sum(monto) as  total
		from fact_transaccionesatm
		where respuesta = 1 and agno = 2010 and mes = 12
		group by terminal
	) A
)
select terminal, sum(monto) as  total
from fact_transaccionesatm, vars
where respuesta = 1 and agno = 2010 and mes = 12
group by terminal, vars.promedio 
having sum(monto) > vars.promedio 


-- Usar un filtro que contenga un texto
select * 
from dim_terminales
where nombre like '%SAN%'
