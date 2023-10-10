-- Practica Bloques Anidados

/* 1. Indicar que valores visualiza X en los 3 casos de
DBMS_OUTPUT.PUT_LINE(x) en este ejemplo */

SET SERVEROUTPUT ON

DECLARE
    x NUMBER := 10;
BEGIN
    dbms_output.put_line(x); -- Se visualiza 10
    DECLARE
        x NUMBER := 20;
    BEGIN
        dbms_output.put_line(x); -- Se visualiza 20
    END;
    dbms_output.put_line(x); -- Se visualiza 10
END;

/* 2. ¿Es este bloque correcto? Si no es así ¿por qué falla?
BEGIN
    DBMS_OUTPUT.PUT_LINE(X);
    DECLARE
        X NUMBER:=20;
    BEGIN
        DBMS_OUTPUT.PUT_LINE(X);
    END;
    DBMS_OUTPUT.PUT_LINE(X);
END;

El bloque no es correcto, debido a que la primer variable "X" no esta definida.

*/

-- El bloque corregido queda: 

DECLARE
    x NUMBER := 10;
BEGIN
    dbms_output.put_line(x);
    DECLARE
        x NUMBER := 20;
    BEGIN
        dbms_output.put_line(x);
    END;
    dbms_output.put_line(x);
END;

-- 3. ¿Es este bloque correcto? Si es así ¿qué valores visualiza X?

DECLARE
    x NUMBER := 10;
BEGIN
    dbms_output.put_line(x);
    BEGIN
        dbms_output.put_line(x);
    END;
    dbms_output.put_line(x);
END;

-- El bloque es correcto, se visualiza el valor de 10 en todos los outputs.











