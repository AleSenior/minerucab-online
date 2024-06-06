CREATE OR REPLACE PROCEDURE PUBLIC.EP_CREAR_EMPLEADO(
	p_ci VARCHAR(10),
	p_p_nombre VARCHAR(16),
	p_s_nombre VARCHAR(16),
	p_p_apellido VARCHAR(20),
	p_s_apellido VARCHAR(20),
	p_sexo CHAR(1),
	p_salario NUMERIC(6,2),
	p_rol NUMERIC(2),
	p_fecha_nacimiento DATE,
	p_fecha_ingreso DATE DEFAULT CURRENT_DATE
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO PUBLIC.EX_EMPLEADO(CI, P_NOMBRE, S_NOMBRE, P_APELLIDO, S_APELLIDO, FECHA_NACIMIENTO, FECHA_INGRESO, SEXO, SALARIO, ROL_CODIGO)
	VALUES(p_ci, p_p_nombre, p_s_nombre, p_p_apellido, p_s_apellido, p_fecha_nacimiento, p_fecha_ingreso, p_sexo, p_salario, p_rol);
	
	INSERT INTO PUBLIC.EX_JORNADA(EMPLEADO_CI, HORARIO_CODIGO)
	SELECT p_ci, CODIGO FROM EX_HORARIO;
END;
$$