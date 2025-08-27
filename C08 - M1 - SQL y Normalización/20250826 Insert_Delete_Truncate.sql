-- Crear una agenda de contactos, guardaremos informacion de personas, 
-- con sus telfonos y direcciones (Fisicas o electronicas)

-- Tabla para almacenar los tipos de telefono
CREATE TABLE TipoTelefono
(
    IdTipoTelefono serial primary key,
    Descripcion varchar(50)

	-- serial: Para que el campo sea autoincremental
	-- primary key: para indicar que ese campo es la llave primaria de la tabla
);


-- Tabla para almacenar los tipos de direcciones
create table TipoDirecciones (
	IdTipoDireccion Serial primary key,
	Descripcion varchar(50)
);


-- Tabla para almacenar los numeros de telefonos
create table NumerosTelefono (
	IdTelefono Serial primary key,
	CodArea varchar(5),
    Telefono VARCHAR(10),
    IdTipoTelefono integer REFERENCES TipoTelefono(IdTipoTelefono)

	-- References: Para crear la relacion hacia otra tabla.
	-- en el caso actual, es para crear una referencia entre la tabla NumerosTelefono y TipoTelefono
);


-- Tabla para almacenar los contactos
create table Contactos (
	IdContacto serial primary key,
	PrimerNombre varchar(50),
	SegundoNombre varchar(50),
	PrimerApellido varchar(50),
	SegundoApellido varchar(50),
	ApellidoCasada varchar(50),
	FechaNacimiento date,
	LugarTrabajo varchar(100)
);


create table refContactoTelefonos(
	IdRelación serial primary key,
	idContacto int references Contactos(IdContacto),
	IdTelefono int references NumerosTelefono(IdTelefono)
)


-- C07 20250825
	
	-- Creación de Tabla de Direcciones
CREATE TABLE Direcciones(
	idDireccion integer serial,
	Direccion varchar(200),
	tipoDireccion integer
)

-- ALTER
-- Para realizar modificaciones

-- Agregar Llave Primaria	
ALTER TABLE Direcciones
ADD CONSTRAINT pk_direcciones PRIMARY KEY (IdDireccion);

-- Cambiar el nombre de un campo
ALTER TABLE Direcciones
RENAME COLUMN TipoDireccion TO IdTipoDireccion;

-- Agregar Relación entre tablas
ALTER TABLE Direcciones
ADD CONSTRAINT fk_direcciones_tipodireccion
FOREIGN KEY (IdTipoDireccion)
REFERENCES TipoDirecciones(IdTipoDireccion);


-- INSERT
-- ingreso de informacion

INSERT INTO TipoTelefono(Descripcion) VALUES('Oficina');
INSERT INTO TipoTelefono(Descripcion) VALUES('Casa');
INSERT INTO TipoTelefono(Descripcion) VALUES('WS');
-- Nota: Los datos de texto deben ser ingresados entre comillas simples

INSERT INTO NumerosTelefono(CodArea,Telefono) VALUES('503','55555555');
INSERT INTO NumerosTelefono(CodArea,Telefono,IdTipoTelefono) VALUES('503','15555555',1);
INSERT INTO NumerosTelefono(CodArea,Telefono,IdTipoTelefono) VALUES('503','25555555',3);

INSERT INTO Contactos(PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, FechaNacimiento, LugarTrabajo)
VALUES ('Carlos', 'Alexander', 'Rosa', 'Martinez', '26/06/1997', 'Empresa X');

INSERT INTO Contactos (PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, ApellidoCasada,FechaNacimiento,LugarTrabajo) 
VALUES ('Denisse','Stephanie','Villacorta','Valiente','-','05/01/1996','Banco_Azul');

insert into Contactos (PrimerNombre, SegundoNombre, PrimerApellido, SegundoApellido, ApellidoCasada, FechaNacimiento, LugarTrabajo)
VALUES ('Juan', 'José', 'Martínez', 'Melgar', '-', '1992/09/03', '-') ;

select * from TipoTelefono;

SELECT * FROM NumerosTelefono;

SELECT * FROM CONTACTOS


-- DROP y TRUNCATE

-- Eliminar una table
drop table direcciones

-- Eliminiar todo el contenido de una tabla
truncate table Contactos