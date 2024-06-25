CREATE OR REPLACE PROCEDURE PUBLIC.SP_COMPRAR_MINERALES(
	p_rif NUMERIC(10),			-- RIF de la empresa
	p_minerales NUMERIC(2)[],	-- Minerales comprados
	p_precios NUMERIC(8,2)[],	-- Precio por kg de cada mineral
	p_kg NUMERIC(10,3)[],		-- Kilogramos comprados de cada mineral
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

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_minerales)) LOOP
		total := total + p_precios[i] * p_kg[i];
	END LOOP;

	INSERT INTO TD_ASIENTO(REF, CUENTA_CODIGO, DEBE, HABER, TARJETA_NUMERO) VALUES
	(cont_asiento, 10, total, NULL, NULL);

	INSERT INTO TD_ASIENTO(REF, CUENTA_CODIGO, DEBE, HABER, TARJETA_NUMERO) VALUES
	(cont_asiento, CASE p_pagado WHEN TRUE THEN 2 ELSE 6 END, NULL, total, NULL);

	INSERT INTO SC_FACTURA(NUMERO, FECHA_REGISTRO, FECHA_CUMPLIMIENTO, ASIENTO_REF, ASIENTO_CODIGO_CUENTA) VALUES
	(cont_factura, CURRENT_DATE, CASE p_pagado WHEN TRUE THEN CURRENT_DATE ELSE NULL END, cont_asiento, 10);

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_minerales)) LOOP
		INSERT INTO SD_FACTURA(NUMERO, ID, CANTIDAD, PRECIO, MINERAL_CODIGO, MAQUINARIA_ID) VALUES
		(cont_factura, i, p_kg[i], p_precios[i], p_minerales[i], NULL);
	END LOOP;

	FOR i IN 1..(SELECT COUNT(*) FROM UNNEST(p_minerales)) LOOP
		UPDATE MX_MINERAL
		SET KG_HABIDOS = KG_HABIDOS + p_kg[i]
		WHERE CODIGO = p_minerales[i];
	END LOOP;
END;
$$