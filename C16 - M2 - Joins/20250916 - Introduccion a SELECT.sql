-- SELECT

-- Seleccionamos todos los datos en tabla
select * from fact_transaccionesatm

-- SELECT: Clausula para consultar
-- COLUMNAS A MOSTRAR
-- FROM 
-- TABLA 


-- SELECCION COLUMNAS
-- Mostrar la fecha, el atm y el monto retirado
select DIA, MES, AGNO, TERMINAL, MONTO from fact_transaccionesatm 

-- Mostrar el codigo de atm y el tipo de ubicacion en el que se encuentra
select terminal, ubicacion from dim_terminales  

-- Mostrar los banco y los bines que tienen
select banco, bin from dim_tipotarjeta dt 


-- SELECCIONAR REGISTROS
-- Seleccione todas las transacciones del 2010
select *
from fact_transaccionesatm
where AGNO = 2010   -- Prueba logica de Seleccion


-- Seleccione todas las transacciones del 2010 y 2012
select *
from fact_transaccionesatm
where agno = 2010 or agno = 2012
-- where agno = 2010 and agno = 2012

-- Seleccione todas las transacciones con mensaje de error 1 y 5
select * from fact_transaccionesatm ft 
where mensaje = 1 or mensaje = 5




-- 20250909
-- Selecione todas las transacciones de los años 2011 y 2012
select * from fact_transaccionesatm 
-- where agno = 2011 or agno = 2012
-- where agno > 2010
where agno >= 2011


-- Selecione todas las transacciones de los años 2011 y 2012
select * from fact_transaccionesatm 
where agno <= 2011

-- Seleccion todas las transacciones de 2011 que fueron aprobadas y las de 2010 que fueron rechazadas
select * 
from fact_transaccionesatm
where
	(agno = 2011 and respuesta = 1)
or	(agno = 2010 and respuesta = 0)



-- ORDER BY
-- Muestreme los cajeros autaticos indicando su codigo,su nombre y codigo de departamento y ordenelos por codigo departamento
select terminal as "Codigo de Cajero", nombre, departamento "Codigo de Terminal"
from dim_terminales
order by departamento desc

-- Negocio pide un reporte de las transacciones de 2012 ordenas por Mes de la transaccion y por monto, el monto sera de mayor a menor y los meses de forma de cronologica
select *
from fact_transaccionesatm
where agno = 2012
order by mes asc, monto desc



-- GROUP BY y Funciones de Agregacion 
-- Cuanto es el monto por agno de los retiros de atm
select agno, mes, terminal, sum(monto) as Monto_Retirado, avg(monto) Promdio_monto, max(monto), min(monto), count(monto)
from fact_transaccionesatm
where 
	trx = 1
	and respuesta = 1
group by agno, mes, terminal
order by  agno, mes, terminal

-- Funciones de agregacion
-- sum, count, avg, max, min

-- Puedes omitir el group by cuando la agregacion sera de todos los datos
select count(*) from fact_transaccionesatm



-- HAVING
select terminal, sum(monto) as Monto_Retirado, avg(monto) Promdio_monto, max(monto), min(monto), count(monto)
from fact_transaccionesatm
where 
	trx = 1
	and respuesta = 1
group by terminal
having COUNT(MONTO) > 300
order by terminal


-- Necesitamos determinar si en oct de 2012, todos los cajeros transaccionaron]
select terminal, count(*)
from fact_transaccionesatm
where agno = 2012 and mes = 10
group by terminal
order by terminal



-- DISTINCT 
select distinct terminal, MONTO
from fact_transaccionesatm 
where agno = 2012 and mes = 10
order by TERMINAL, MONTO



select * 
from fact_transaccionesatm
limit 10


-- top 3 de los cajeros que mas monto depositado ha recibido

select TERMINAL, SUM(MONTO)
from fact_transaccionesatm
where 
	TRX = 2 and respuesta = 1
group by TERMINAL
order by SUM(MONTO) desc
limit 3



-- Orden de nuestras sentencias
-- select
	-- distinct 
	-- from
	-- where
	-- group by 
	-- having
	-- order by
	-- limit 
	

-- Ej01. De las trasnccines del ultimo trimestre de 2011, cuales son los 5 atms que presentaron mas transacciones denegadas
select terminal, count(*)
from fact_transaccionesatm
where agno = 2011 and mes > 9 and respuesta = 0
group by terminal
order by count(respuesta) desc
limit 5


-- 20250910 

-- Ej02. Cuales son los motivos de rechazo que mas presentaron los retiros de atm en mayo de 2010
select mensaje, count(*)
from fact_transaccionesatm
where agno = 2010 and mes = 5 and respuesta= 0
group by mensaje
order by count(*) desc


-- Ej03. Cuántos atms hay por departamento
select departamento, count(*)
from dim_terminales
group by departamento
order by count(*) desc

-- Ej04. Identifica los 3 cajeros de los que más dinero se retiró en diciembre 2010
select terminal, sum(monto)
from fact_transaccionesatm
where agno = 2010 and mes = 12 and trx = 1 and respuesta = 1
group by terminal
order by sum(monto) desc
limit 3


-- Ej06. Para el año 2010, cuántas transacciones de retiro hay por mes, además cuánto suman esas transacciones, cuál es su promedio
select mes, count(*), sum(monto), avg(monto)
from fact_transaccionesatm
where agno = 2010 and trx = 1 and respuesta = 1
group by mes
order by mes


-- JOIN's
-- Transacciones por terminal
select TERMINAL, COUNT(*)
from fact_transaccionesatm
group by TERMINAL
order by COUNT(*) desc 

-- Usando joins
select A.tERMINAL, NOMBRE, COUNT(*)
from fact_transaccionesatm A
join dim_terminales B on A.TERMINAL = B.TERMINAL 
group by A.TERMINAL, NOMBRE
order by COUNT(*) desc


-- Usando joins
select dim_terminales.tERMINAL, NOMBRE, COUNT(*)
from fact_transaccionesatm 
join dim_terminales on fact_transaccionesatm.TERMINAL = dim_terminales.TERMINAL 
group by dim_terminales.TERMINAL, NOMBRE
order by COUNT(*) desc