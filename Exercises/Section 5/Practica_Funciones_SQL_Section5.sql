-- Prácticas funciones SQL en PL/SQL

/* 1. Visualizar iniciales de un nombre
• Crea un bloque PL/SQL con tres variables VARCHAR2:
    o Nombre
    o apellido1
    o apellido2
• Debes visualizar las iniciales separadas por puntos.
• Además siempre en mayúscula
• Por ejemplo alberto pérez García debería aparecer--> A.P.G */

SET SERVEROUTPUT ON

DECLARE
    nombre    VARCHAR2(100) := 'alberto';
    apellido1 nombre%TYPE := 'perez';
    apellido2 nombre%TYPE := 'garcia';
BEGIN
    dbms_output.put_line(UPPER(SUBSTR(nombre, 1, 1))
                         || '.'
                         || UPPER(SUBSTR(apellido1, 1, 1))
                         || '.'
                         || UPPER(SUBSTR(apellido2, 1, 1)));
END;


-- 2. Averiguar el nombre del día que naciste, por ejemplo "Martes"

DECLARE
    birth_date DATE := TO_DATE ( '22-01-1998', 'DD-MM-YYYY' );
    birth_day  VARCHAR2(100);
BEGIN
    birth_day := to_char(birth_date, 'DAY');
    dbms_output.put_line('El dia que nací es: ' || birth_day);
END;