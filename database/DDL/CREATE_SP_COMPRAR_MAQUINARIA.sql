CREATE OR REPLACE PROCEDURE PUBLIC.SP_COMPRAR_MAQUINARIA(
	p_rif NUMERIC(10),			-- RIF de la empresa
	p_maquinaria NUMERIC(4)[],	-- Máquinas compradas
	p_precios NUMERIC(8,2)[],	-- Precio unitario de cada máquina
	p_unidades NUMERIC(6)[],	-- Unidades compradas de cada máquina
	p_pagado BOOLEAN			-- Fue pagado o no
)
LANGUAGE plpgsql
AS $$
DECLARE
	cont_asiento NUMERIC(8);
	cont_factura NUMERIC(8);
	empresa_nombre VARCHAR(60);
	total NUMERIC(8,2);
BEGIN
	SELECT NOMBRE
	INTO empresa_nombre
	FROM CX_EMPRESA
	WHERE RIF = p_rif;

	SELECT COUNT(*) + 1
	INTO cont_asiento
	FROM TC_ASIENTO;

	SELECT COUNT(*) + 1
	INTO cont_factura
	FROM SC_FACTURA;

	INSERT INTO TC_ASIENTO(REF, FECHA_TRANSACCION, DESCRIPCION)
	VALUES(cont_asiento, CURRENT_DATE, 'P/R Compra a '||empresa_nombre);

	total := 0;

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_maquinaria)) LOOP
		total := total + p_precios[i] * p_unidades[i];
	END LOOP;

	INSERT INTO TD_ASIENTO(REF, CUENTA_CODIGO, DEBE, HABER, TARJETA_NUMERO) VALUES
	(cont_asiento, 11, total, NULL, NULL);

	INSERT INTO TD_ASIENTO(REF, CUENTA_CODIGO, DEBE, HABER, TARJETA_NUMERO) VALUES
	(cont_asiento, CASE p_pagado WHEN TRUE THEN 2 ELSE 6 END, NULL, total, NULL);

	INSERT INTO SC_FACTURA(NUMERO, FECHA_REGISTRO, FECHA_CUMPLIMIENTO, ASIENTO_REF, ASIENTO_CODIGO_CUENTA) VALUES
	(cont_factura, CURRENT_DATE, CASE p_pagado WHEN TRUE THEN CURRENT_DATE ELSE NULL END, cont_asiento, 11);

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_maquinaria)) LOOP
		INSERT INTO SD_FACTURA(NUMERO, ID, CANTIDAD, PRECIO, MINERAL_CODIGO, MAQUINARIA_ID) VALUES
		(cont_factura, i, p_unidades[i], p_precios[i] * p_unidades[i], p_maquinaria[i], NULL);
	END LOOP;

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_maquinaria)) LOOP
		UPDATE MX_MAQUINARIA
		SET CANTIDAD = CANTIDAD + p_unidades[i]
		WHERE ID = p_maquinaria[i];
	END LOOP;
END;
$$