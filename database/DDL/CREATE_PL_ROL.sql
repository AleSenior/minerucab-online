CREATE TABLE PUBLIC.PL_ROL(
	CODIGO		NUMERIC(2)	NOT NULL UNIQUE,
	NOMBRE		VARCHAR(30)	NOT NULL,
	DESCRIPCION	TEXT		NOT NULL,
	
	CONSTRAINT PK_P_ROL PRIMARY KEY(CODIGO)
);