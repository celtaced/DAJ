select *
from fact_transaccionesatm


-- FUNCIONES

-- Presumir que el monto es una transaccion con IVA incluido, calculen el iva y el valor de la venta
-- IVA = 15%
select 
	make_date(agno, mes, dia) as fecha_transaccion,
	tarjeta, 
	monto, 
	-- monto/1.13 as venta, 
	ROUND(MONTO/1.13, 2) as venta,
	round(monto - monto/1.13, 2) as IVA
from fact_transaccionesatm




-- Funciones matematicas
select 
	tarjeta, 
	monto, 
	-- monto/1.13 as venta, 
	MONTO/1.13,
	ROUND(MONTO/1.13, 2) as venta, -- REDONDEO 
	CEIL(MONTO/1.13), -- ENTERO SUPERIOR
	FLOOR(MONTO/1.13), -- ENTERO INFERIO
	POWER(2, 3), 
	RANDOM()
from fact_transaccionesatm

-- FUNCIONES DE TIEMPO
select NOW(), current_DATE, 

select 
	dia, mes, agno,
	make_date(agno, mes, dia) as fecha_transaccion,
	AGE(make_date(agno, mes, dia)),
	extract(year from make_date(agno, mes, dia)),
	EXTRACT(DOW from make_date(agno, mes, dia))
from fact_transaccionesatm


select 
	NOMBRE,
	LOWER(NOMBRE), -- UPPPER
	SUBSTRING('CENTRO%' from NOMBRE),
	LENGTH(NOMBRE),
	NOMBRE,
	DEPARTAMENTO,
	CONCAT(NOMBRE,DEPARTAMENTO)
from dim_terminales



-- 
select TERMINAL, SUM(MONTO)
from fact_transaccionesatm
group by TERMINAL
order by TERMINAL