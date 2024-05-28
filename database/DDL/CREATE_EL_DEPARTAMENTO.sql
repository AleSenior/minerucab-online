CREATE TABLE PUBLIC.EL_DEPARTAMENTO(
	NUMERO		NUMERIC(4)  NOT NULL UNIQUE,
	NOMBRE		VARCHAR(30) NOT NULL,
	DESCRIPCION	TEXT		NOT NULL,
	
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY(NUMERO)
);