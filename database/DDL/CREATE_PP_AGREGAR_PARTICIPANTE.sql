CREATE OR REPLACE PROCEDURE PP_AGREGAR_PARTICIPANTE(
	p_ci VARCHAR(10),
	p_proyecto NUMERIC(8),
	p_fase NUMERIC(2),
	p_actividad NUMERIC(2),
	p_rol NUMERIC(2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO PX_PARTICIPANTE(
		PROYECTO_ID,
		FASE_ID,
		ACTIVIDAD_NUMERO,
		EMPLEADO_CI,
		ROL_CODIGO
	) VALUES (
		p_proyecto,
		p_fase,
		p_actividad,
		p_ci,
		p_rol
	);
END $$;