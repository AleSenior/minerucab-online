CREATE TABLE PUBLIC.SL_METODO_PAGO(
	ID			NUMERIC(2)	NOT NULL UNIQUE,
	NOMBRE		VARCHAR(20)	NOT NULL,
	DESCRIPCION	VARCHAR(60)	NOT NULL,
	TARJETA		BOOLEAN		NOT NULL DEFAULT FALSE,
	
	CONSTRAINT PK_METODO_PAGO	PRIMARY KEY(ID)
);