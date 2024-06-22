CREATE OR REPLACE PROCEDURE PUBLIC.EP_DAR_PERMISOS(
	p_ci VARCHAR(10),
    p_privilegio_id NUMERIC(2),
    p_accion CHAR(1) DEFAULT 'A'
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_accion NOT IN ('A', 'L', 'E') THEN
        RAISE EXCEPTION 'ACCION INVALIDA';
    END IF;

    IF p_accion = 'A' THEN
        INSERT INTO EX_PERMISO(USUARIO_CI, PRIVILEGIO_ID, ACCION) VALUES
        (p_ci, p_privilegio_id, 'L'),
        (p_ci, p_privilegio_id, 'E');
    ELSE
        INSERT INTO EX_PERMISO(USUARIO_CI, PRIVILEGIO_ID, ACCION)
        VALUES(p_ci, p_privilegio_id, p_accion);
    END IF;
END;
$$