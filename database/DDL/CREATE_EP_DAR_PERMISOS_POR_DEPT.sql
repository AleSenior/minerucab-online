CREATE OR REPLACE PROCEDURE PUBLIC.EP_DAR_PERMISOS_POR_DEPT(
	p_ci VARCHAR(10)
)
LANGUAGE plpgsql
AS $$
DECLARE
    NUMERO_DEPT NUMERIC(4);
BEGIN
    SELECT NUMERO
    INTO NUMERO_DEPT
    FROM EL_DEPARTAMENTO
    JOIN EL_CARGO ON EL_DEPARTAMENTO.NUMERO = EL_CARGO.DEPARTAMENTO_NUMERO
    JOIN EX_EMPLEADO ON EL_CARGO.CODIGO = EX_EMPLEADO.CARGO_CODIGO
    WHERE EX_EMPLEADO.CI = p_ci;

    CASE NUMERO_DEPT
        WHEN 1 THEN 
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 2 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 3 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 4 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 5 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 6 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 7 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 4);
        WHEN 8 THEN
            CALL EP_DAR_PERMISOS(p_ci, 2);
            CALL EP_DAR_PERMISOS(p_ci, 3);
        WHEN 9 THEN
            CALL EP_DAR_PERMISOS(p_ci, 7);
            CALL EP_DAR_PERMISOS(p_ci, 8, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 9, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 10, 'L');
        WHEN 10 THEN
            CALL EP_DAR_PERMISOS(p_ci, 6);
            CALL EP_DAR_PERMISOS(p_ci, 7);
            CALL EP_DAR_PERMISOS(p_ci, 8);
            CALL EP_DAR_PERMISOS(p_ci, 9, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 10);
        WHEN 11 THEN
            CALL EP_DAR_PERMISOS(p_ci, 5);
            CALL EP_DAR_PERMISOS(p_ci, 7);
            CALL EP_DAR_PERMISOS(p_ci, 8, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 9);
            CALL EP_DAR_PERMISOS(p_ci, 10);
        WHEN 12 THEN
            CALL EP_DAR_PERMISOS(p_ci, 5);
            CALL EP_DAR_PERMISOS(p_ci, 6);
        WHEN 13 THEN
            CALL EP_DAR_PERMISOS(p_ci, 5);
            CALL EP_DAR_PERMISOS(p_ci, 6);
        WHEN 14 THEN
            CALL EP_DAR_PERMISOS(p_ci, 1);
            CALL EP_DAR_PERMISOS(p_ci, 2);
            CALL EP_DAR_PERMISOS(p_ci, 5, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 6, 'L');
            CALL EP_DAR_PERMISOS(p_ci, 7, 'L');
        ELSE
            RAISE EXCEPTION 'DEPARTAMENTO INVALIDO';
    END CASE;
END;
$$