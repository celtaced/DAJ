-- Crear una agenda de contactos, guardaremos informacion de personas, 
-- con sus telfonos y direcciones (Fisicas o electronicas)

CREATE TABLE IF NOT EXISTS public."TipoTelefono"
(
    "IdTipoTelefono" integer NOT NULL DEFAULT nextval('"TipoTelefono_IdTipoTelefono_seq"'::regclass),
    "Descripcion" character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT "TipoTelefono_pkey" PRIMARY KEY ("IdTipoTelefono")
)


create table TipoDirecciones (
	IdTipoDireccion Serial primary key,
	Descripcion varchar(50)
)

create table NumerosTelefono (
	IdTelefono Serial primary,
	
)


