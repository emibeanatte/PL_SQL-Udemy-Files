-- Practica Excepciones

/* 1- Crear una SELECT (no un cursor explícito) que devuelva el nombre de un
empleado pasándole el EMPLOYEE_ID en el WHERE,

• Comprobar en primer lugar que funciona pasando un empleado
existente

• Pasar un empleado inexistente y comprobar que genera un error

• Crear una zona de EXCEPTION controlando el NO_DATA_FOUND
para que pinte un mensaje como “Empleado inexistente” */


SET SERVEROUTPUT ON

DECLARE
    empl EMPLOYEES%ROWTYPE;
BEGIN
    SELECT
        *   INTO empl
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 1000;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Empleado inexistente.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error indefinido.');
END;


/* 2- Modificar la SELECT para que devuelva más de un empleado, por ejemplo
poniendo EMPLOYEE_ID> 100. Debe generar un error. Controlar la
excepción para que genere un mensaje como “Demasiados empleados
en la consulta” */

DECLARE
    empl EMPLOYEES%ROWTYPE;
BEGIN
    SELECT
        *   INTO empl
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID > 100;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Demasiados empleados en la consulta.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error indefinido.');
END;


/* 3- Modificar la consulta para que devuelva un error de división por CERO,
por ejemplo, vamos a devolver el salario en vez del nombre y lo dividimos
por 0. En este caso, en vez de controlar la excepción directamente,
creamos una sección WHEN OTHERS y pintamos el error con SQLCODE
y SQLERR */

DECLARE
    salario EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT
        (SALARY / 0)  INTO salario
    FROM
        EMPLOYEES
    WHERE
        EMPLOYEE_ID = 100;
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        dbms_output.put_line('Demasiados empleados en la consulta.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: '||SQLCODE||'. Message: '||SQLERRM);
END;



/* 4- El error -00001 es clave primaria duplicada.

a. Aunque ya existe una predefinida (DUP_VAL_ON_INDEX) vamos
a crear una excepción no -predefinida que haga lo mismo.
b. Vamos a usar la tabla REGIONS para hacerlo más fácil
c. Usamos PRAGMA EXCEPTION_INIT y creamos una excepción
denominada “duplicado”.
d. Cuando se genere ese error debemos pintar “Clave duplicada,
intente otra”. */

DECLARE
    duplicado EXCEPTION;
    PRAGMA EXCEPTION_INIT(duplicado,-00001);
BEGIN
    INSERT INTO REGIONS
    VALUES (1,'Argentina');
    
    COMMIT;
EXCEPTION
    WHEN duplicado THEN
        dbms_output.put_line('Clave duplicada, intente otra.');
    WHEN OTHERS THEN
        dbms_output.put_line('Error: '||SQLCODE||'. Message: '||SQLERRM);
END;
















