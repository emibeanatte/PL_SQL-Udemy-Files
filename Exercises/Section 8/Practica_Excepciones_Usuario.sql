-- Práctica con EXCEPCIONES DE USUARIO

/* 1- Crear una Excepción personalizada denominada
CONTROL_REGIONES.
• Debe dispararse cuando al insertar o modificar una región
queramos poner una clave superior a 200. Por ejemplo usando una
variable con ese valor.
• En ese caso debe generar un texto indicando algo así como
“Codigo no permitido. Debe ser inferior a 200”
• Recordemos que las excepciones personalizadas deben
dispararse de forma manual con el RAISE. */

SET SERVEROUTPUT ON

DECLARE
    control_regiones EXCEPTION;
    clave REGIONS.REGION_ID%TYPE;
    nombre REGIONS.REGION_NAME%TYPE;
BEGIN
    clave := 300;
    nombre := 'Argentina';
    IF clave > 200 THEN
        RAISE control_regiones;
    ELSE
        INSERT INTO REGIONS
        VALUES (clave,nombre);
        COMMIT;
    END IF;
EXCEPTION
    WHEN control_regiones THEN
        dbms_output.put_line('Codigo no permitido. Debe ser inferior a 200.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: '||SQLCODE||'. Message: '||SQLERRM);
END;