CREATE TABLE PUBLIC.GL_LUGAR(
	ID			NUMERIC(6)	NOT NULL,
	NOMBRE		VARCHAR(50)	NOT NULL,
	TIPO		CHAR(3)		NOT NULL,
	LUGAR_ID	NUMERIC(6),
	
	CONSTRAINT PK_LUGAR			PRIMARY KEY(ID),
	CONSTRAINT FK_LUGAR_LUGAR	FOREIGN KEY(LUGAR_ID) REFERENCES PUBLIC.GL_LUGAR(ID),
	CONSTRAINT CK_LUGAR_TIPO	CHECK(TIPO IN ('PAI', 'EST', 'MUN', 'PAR'))
);