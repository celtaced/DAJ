-- Renombremos todas las tablas para unificar
ALTER TABLE h1 RENAME to dim_TiposTarjeta;
ALTER TABLE h2 RENAME to dim_InfoCajeros;
ALTER TABLE h3 RENAME to dim_departamentos;
ALTER TABLE h4 RENAME to dim_respuestas;
ALTER TABLE h5 RENAME to dim_mensajes;
ALTER TABLE h6 RENAME TO dim_TipoTransaccion;
ALTER TABLE h7 RENAME to fact_Transacciones;

-- CREANDO LAS RELACIONES ENTRE TABLAS
	-- Nomenglatura de lastablas en el modelo dimensional:
		-- dim: Tabla de Dimension
		-- fact: Tabla de Hechos
		-- stg: Staging (Procesamiento temporal)

-- 1. Para todas las tablas dimensiones debemos crear las llaves primarias.

-- Tabla informacion de Cajeros
alter table dim_InfoCajeros
add constraint pk_cajeros
primary key(Terminal);

-- Tabla de Tipo de transacciones
alter table dim_tipotransaccion 
add constraint pk_tipotransaccion
primary key (idtrx);

-- Tabla de Tipo de Tarjetas
alter table dim_TiposTarjeta
add constraint pk_TipoTjta
primary key(BIN);

-- Quedan pendientes h3, h4 y h5



-- 2. Creamos las llaves foraneas. Revisemos tres casos posibles casos de la base dedatos.

-- Caso 1: Todas las llaves foraneas usadas en la tabla de hechos se encuentran en la tabla referida
alter table fact_Transacciones
add constraint fk_fact_cajero
foreign key (terminal)
references dim_InfoCajeros(terminal);


-- Caso 2: Existe una llave foranea (TRX = 30) que no esta en la tabla referida
	-- Al ejecutarel alter table nos indicara un error [La llave (trx)=(30) no está presente en la tabla «dim_tipotransaccion».] 
alter table fact_Transacciones 
add constraint fk_fact_tipostrx
foreign key (trx)
references dim_tipotransaccion(idtrx)

-- Cosideramos dos posibles soluciones: 
	-- a) Eliminar de la tabla de hechos todos los registros con TRX = 30, esto si la transaccion 30 no sera parte del alcance de nuestro analisis
	-- b) Agregar el idtrx = 30 a la tabla de transacciones, esto si es una nueva transaccion o entra en nuestro analisis
	INSERT INTO dim_tipotransaccion (idtrx, descripcion) VALUES(30, 'CONSULTAS');


-- Caso 3: Existen muchas llaves foraneas que no estan en la tabla referida.
-- En este caso existira una regla de negocio, si un BIN de la tabla de hechos no esta en la tabla de tipos de tarjeta, se considerara una tarjeta internacional
-- debido que existe una regla de negocio que nos indica que no siempre existira una llave registrada, podemos modificar el script, con la propiedad not valid
alter table fact_Transacciones
add constraint fk_fact_tarjeta
foreign key (BIN)
references dim_TiposTarjeta(BIN) not valid
	-- Not valid, creara la relacion entre la tabla de hechos y la dimension de tipos de tarjeta, pero no exigira que en esta ultima esten todos los bines de la tabla de hechos.


-- Quedan pendientes las relaciones de la tabla de hechos hacia la tabla h4 y h5. La tabla h3 debe ser relacionada hacia la tabla h2