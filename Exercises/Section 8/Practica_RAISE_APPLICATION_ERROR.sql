-- Práctica con RAISE_APPLICATION_ERROR

/* Práctica con RAISE_APPLICATION_ERROR
1. Modificar la practica anterior para disparar un error con RAISE_APPLICATION
en vez de con PUT_LINE.
a. Esto permite que la aplicación pueda capturar y gestionar el error que
devuelve el PL/SQL */

SET SERVEROUTPUT ON

DECLARE
    clave REGIONS.REGION_ID%TYPE;
    nombre REGIONS.REGION_NAME%TYPE;
BEGIN
    clave := 300;
    nombre := 'Argentina';
    IF clave > 200 THEN
        RAISE_APPLICATION_ERROR(-20056,'Codigo no permitido. Debe ser inferior a 200.');
    ELSE
        INSERT INTO REGIONS
        VALUES (clave,nombre);
        COMMIT;
    END IF;
END;