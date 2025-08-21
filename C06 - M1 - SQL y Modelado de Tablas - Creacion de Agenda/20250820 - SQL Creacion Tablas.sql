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