-- Práctica Variables

/* 1-Determinar que bloques PL/SQL son correctos.

 A/
 
 BEGIN
 END;
 
 B/
 DECLARE x INTEGER(10);
 END;
 
 C/
 DECLARE
 BEGIN
 END;
 
 D/
 DECLARE
    X INTEGER(10);
 BEGIN
    DBMS_OUTPUT.PUT_LINE(x);
 END;
 
 */
 
 -- El bloque correcto es el D porque es el unico que esta completo.
 
 -- 2- Crear dos variables de tipo numérico y visualizar su suma

SET SERVEROUTPUT ON;

DECLARE
    n1 NUMBER := 5;
    n2 NUMBER := 5;
BEGIN
    dbms_output.put_line(n1 + n2);
END;


/* 3- Modificar el ejemplo anterior y ponemos null como valor de una de las
variables. ¿Qué resultado arroja? Volvemos a ponerla un valor numérico */

DECLARE
    n1 NUMBER := 5;
    n2 NUMBER := NULL;
BEGIN
    dbms_output.put_line(n1 + n2);
END;

-- Arroja un resultado null

/* 4- Añadir una constante al ejercicio. Sumamos las 2 variables y la
constante. Intentar modificar la constante. ¿Es posible? */

DECLARE
    n1 NUMBER := 5;
    n2 NUMBER := 5;
    n3 CONSTANT NUMBER := 10;
BEGIN
    dbms_output.put_line(n1 + n2 + n3);
END;

-- No es posible modificar una constante.

/* 5- Crear un bloque anónimo que tenga una variable de tipo VARCHAR2 con
nuestro nombre, otra numérica con la edad y una tercera con la fecha de
nacimiento. Visualizarlas por separado y luego intentar concatenarlas. ¿es
posible? */

DECLARE
    nombre     VARCHAR2(100) := 'Emiliano';
    edad       NUMBER := 25;
    birth_date DATE := TO_DATE ( '22-01-1998', 'DD-MM-YYYY' );
BEGIN
    dbms_output.put_line(nombre);
    dbms_output.put_line(edad);
    dbms_output.put_line(birth_date);
    dbms_output.put_line(nombre
                         || ' '
                         || edad
                         || ' '
                         || birth_date);

END;

-- Es posible concatenarlas.