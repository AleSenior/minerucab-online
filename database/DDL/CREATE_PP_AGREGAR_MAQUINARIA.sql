CREATE OR REPLACE PROCEDURE PP_AGREGAR_MAQUINARIA(
	p_id NUMERIC(4)[],
    p_cantidad NUMERIC(6)[],
	p_proyecto NUMERIC(8),
	p_fase NUMERIC(2),
	p_actividad NUMERIC(2)
)
LANGUAGE plpgsql
AS $$
BEGIN
	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_id)) LOOP
		INSERT INTO PX_USO(
			PROYECTO_ID,
			FASE_ID,
			ACTIVIDAD_NUMERO,
			MAQUINARIA_ID,
			CANTIDAD
		) VALUES (
			p_proyecto,
			p_fase,
			p_actividad,
			p_id[i],
			p_cantidad[i]
		);
	END LOOP;
END $$;