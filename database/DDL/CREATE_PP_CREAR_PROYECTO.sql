CREATE OR REPLACE PROCEDURE PUBLIC.PP_CREAR_PROYECTO(
    p_nombre VARCHAR(30),
    p_yacimiento NUMERIC(6),
    p_fecha_inicio DATE,
    p_fecha_fin_est DATE,
    p_estatus CHAR(1) DEFAULT 'N',
    p_nuevo_pozo BOOLEAN DEFAULT FALSE
)
LANGUAGE plpgsql
AS $$
DECLARE
    PROYECTO_ID NUMERIC(8);
    DESCRIPCION TEXT;
    MINERAL NUMERIC(2);
BEGIN
    SELECT COUNT(*) + 1
    INTO PROYECTO_ID
    FROM PUBLIC.PX_PROYECTO;

    SELECT 'Proyecto de explotación de yacimiento ' || NOMBRE, MINERAL_CODIGO
    INTO DESCRIPCION, MINERAL
    FROM PUBLIC.MH_YACIMIENTO
    WHERE ID = p_yacimiento;

    INSERT INTO PUBLIC.PX_PROYECTO(ID, NOMBRE, DESCRIPCION, YACIMIENTO_CODIGO, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS)
    VALUES(PROYECTO_ID, p_nombre, DESCRIPCION, p_yacimiento, p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

    CASE MINERAL
        WHEN 1 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 2 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 3 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 4 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 5 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 6 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 7 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        WHEN 8 THEN
            INSERT INTO PUBLIC.PX_FASE(PROYECTO_ID, ID, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 'Investigación', 'Fase de investigación documental del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 'Exploración', 'Fase de investigación de campo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 'Análisis de resultados', 'Fase de análisis de resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 'Explotación', 'Fase de explotación de yacimiento del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 'Documentación', 'Fase de documentación del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);

            INSERT INTO PUBLIC.PX_ACTIVIDAD(PROYECTO_ID, FASE_ID, NUMERO, NOMBRE, DESCRIPCION, FECHA_INICIO, FECHA_FIN_EST, FECHA_FIN, ESTATUS) VALUES
            (PROYECTO_ID, 1, 1, 'Recopilación de documentación', 'Búsqueda de documentación pertinente a la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 3, 'Redacción de informe', 'Documentación de resultados de la evaluación anterior, con el plan de ejecución, personal requerido, medidas de seguridad, etc.', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 4, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 1, 5, 'Notificación a personal', 'Notificar al personal registrado para la fase de exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 1, 'Transporte a yacimiento', 'Transportar al personal encargado de la exploración del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 2, 'Reconocimiento geológico', 'Estudio del área del yacimiento a explotar', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 3, 'Muestreo y ensayos', 'Toma y pruebas de muestras de la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 4, 'Evaluación de resultados', 'Evaluación y documentación de los resultados del muestreo y los ensayos, con sus conclusiones y recomendaciones', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 2, 5, 'Envío de informe', 'Envío del informe de resultados de la evaluación al jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 1, 'Revisión de informe', 'Revisión de informe de resultados de la exploración por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 2, 'Aprobación de informe', 'Aprobación por parte del jefe de proyecto y los departamentos de seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 3, 'Notificación a personal', 'Notificar al personal registrado para la fase de explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 4, 'Reserva de maquinaria', 'Reservar maquinaria utilizada para la explotación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 3, 5, 'Transporte a yacimiento', 'Transportar al personal y la maquinaria reservados para la explotación del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 1, 'Levantamiento topográfico', 'Determinación de la altitud de distintos puntos en la superficie del yacimiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 2, 'Determinación de punto de excavación', 'Hallar punto de excavación más conveniente según la información obtenida en el levantamiento', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 3, 'Perforación', 'Perforación de pozo en el punto de excavación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 4, 'Extracción de minerales', 'Evaluación y documentación de los resultados de la exploración', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 4, 5, 'Redacción de informe', 'Redactar informe de resultados de la explotación del pozo', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 1, 'Recopilación de documentación', 'Recolectar toda la información documentada a lo largo del proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 2, 'Evaluación de información', 'Lectura y análisis de la información recopilada', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 3, 'Redacción de informe final', 'Registrar toda la información documentada del proyecto, junto con las conclusiones y recomendaciones del jefe de proyecto', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 4, 'Revisión de informe final', 'Someter el informe a revisión de los departamentos de minería, seguridad y ambiente', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus),
            (PROYECTO_ID, 5, 5, 'Publicación de informe final', 'Enviar el informe revisado por los departamentos de minería, seguridad y ambiente para su publicación', p_fecha_inicio, p_fecha_fin_est, NULL, p_estatus);
        ELSE
            RAISE EXCEPTION 'Mineral inválido';
    END CASE;
END
$$