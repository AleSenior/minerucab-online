CREATE TABLE PUBLIC.SD_FACTURA(
	NUMERO			NUMERIC(8)		NOT NULL,
	ID				NUMERIC(4)		NOT NULL,
	CANTIDAD		NUMERIC(10,3)	NOT NULL,
	PRECIO			NUMERIC(8,2)	NOT NULL,
	MINERAL_CODIGO	NUMERIC(2)		NOT NULL,
	MAQUINARIA_ID	NUMERIC(4)		NOT NULL,
	
	CONSTRAINT PK_D_FACTURA				PRIMARY KEY(NUMERO, MINERAL_CODIGO),
	CONSTRAINT FK_D_FACTURA_C_FACTURA	FOREIGN KEY(NUMERO) REFERENCES PUBLIC.SC_FACTURA(NUMERO),
	CONSTRAINT FK_D_ASIENTO_MINERAL		FOREIGN KEY(MINERAL_CODIGO) REFERENCES PUBLIC.MX_MINERAL(CODIGO),
	CONSTRAINT FK_D_ASIENTO_MAQUINARIA	FOREIGN KEY(MAQUINARIA_ID) REFERENCES PUBLIC.MX_MAQUINARIA(ID),
	CONSTRAINT CK_MINERAL_MAQUINARIA	CHECK((MINERAL_CODIGO IS NOT NULL AND MAQUINARIA_ID IS NULL) OR (MINERAL_CODIGO IS NULL AND MAQUINARIA_ID IS NOT NULL))
);