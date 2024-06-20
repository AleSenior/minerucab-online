CREATE TABLE PUBLIC.PX_FASE(
	PROYECTO_ID		NUMERIC(8)	NOT NULL,
	ID				NUMERIC(2)	NOT NULL,
	NOMBRE			VARCHAR(40)	NOT NULL,
	DESCRIPCION		TEXT		NOT NULL,
	FECHA_INICIO	DATE		NOT NULL,
	FECHA_FIN_EST	DATE		NOT NULL,
	FECHA_FIN		DATE,
	ESTATUS			CHAR(1)		NOT NULL,
	
	CONSTRAINT PK_FASE			PRIMARY KEY(PROYECTO_ID, ID),
	CONSTRAINT FK_FASE_PROYECTO	FOREIGN KEY(PROYECTO_ID) REFERENCES PUBLIC.PX_PROYECTO(ID),
	CONSTRAINT CK_FASE_ESTATUS	CHECK(ESTATUS IN ('A', 'I', 'F', 'N'))
);