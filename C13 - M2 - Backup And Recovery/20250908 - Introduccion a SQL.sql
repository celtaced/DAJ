-- SELECT

-- Seleccionamos todos los datos en tabla
select * from fact_transaccionesatm

-- SELECT: Clausula para consultar
-- COLUMNAS A MOSTRAR
-- FROM 
-- TABLA 


-- Mostrar la fecha, el atm y el monto retirado
select DIA, MES, AGNO, TERMINAL, MONTO from fact_transaccionesatm 

-- Mostrar el codigo de atm y el tipo de ubicacion en el que se encuentra
select terminal, ubicacion from dim_respuestas  

-- Mostrar los banco y los bines que tienen
select banco, bin from dim_tipotarjeta dt 


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
