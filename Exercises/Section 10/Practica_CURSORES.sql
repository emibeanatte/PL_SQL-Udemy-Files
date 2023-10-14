-- PRÁCTICAS CON CURSORES

/* • 1-Hacer un programa que tenga un cursor que vaya visualizando los salarios de
los empleados. Si en el cursor aparece el jefe (Steven King) se debe generar un
RAISE_APPLICATION_ERROR indicando que el sueldo del jefe no se puede
ver */
SET SERVEROUTPUT ON

DECLARE
    CURSOR cur IS SELECT FIRST_NAME, LAST_NAME, SALARY
        FROM EMPLOYEES;
BEGIN
    FOR i IN cur LOOP
        IF i.FIRST_NAME = 'Steven' AND i.LAST_NAME = 'King' THEN
            RAISE_APPLICATION_ERROR(-20099,'Error, el salario del jefe no puede verse.');
        ELSE
            dbms_output.put_line('Empleado/a '|| i.FIRST_NAME || ', ' || i.LAST_NAME||' Salario: '|| i.SALARY);
        END IF;
    END LOOP;
END;


/* 2- Vamos averiguar cuales son los JEFES (MANAGER_ID) de cada
departamento. En la tabla DEPARTMENTS figura el MANAGER_ID de cada
departamento, que a su vez es también un empleado. Hacemos un bloque con
dos cursores. (Esto se puede hacer fácilmente con una sola SELECT pero vamos
a hacerlo de esta manera para probar parámetros en cursores).
o El primero de todos los empleados
o El segundo de departamentos, buscando el MANAGER_ID con el
parámetro que se le pasa.
o Por cada fila del primero, abrimos el segundo cursor pasando el
EMPLOYEE_ID
o Si el empleado es MANAGER_ID en algún departamento debemos
pintar el Nombre del departamento y el nombre del MANAGER_ID
diciendo que es el jefe.
o Si el empleado no es MANAGER de ningún departamento debemos
poner “No es jefe de nada” */

DECLARE
    CURSOR c1 IS SELECT * FROM EMPLOYEES;
    CURSOR c2 (m_id DEPARTMENTS.MANAGER_ID%TYPE) IS SELECT * FROM DEPARTMENTS
    WHERE MANAGER_ID = m_id;
    
    depto DEPARTMENTS%ROWTYPE;
    jefe DEPARTMENTS.MANAGER_ID%TYPE;
BEGIN
    FOR i IN c1 LOOP
    
        OPEN c2(i.EMPLOYEE_ID);
        FETCH c2 INTO depto;
        IF c2%FOUND THEN
            dbms_output.put_line(i.FIRST_NAME || ' es el jefe del departamento ' || depto.DEPARTMENT_NAME);   
        ELSE
            dbms_output.put_line(i.FIRST_NAME || ' no es jefe de nada.');
        END IF;
        CLOSE c2;
    END LOOP;
END;


/* • 3-Crear un cursor con parámetros que pasando el número de departamento
visualice el número de empleados de ese departamento */

DECLARE
    CURSOR cur (d DEPARTMENTS.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES
    WHERE DEPARTMENT_ID = d;
    
    codigo DEPARTMENTS.DEPARTMENT_ID%TYPE;
    empls NUMBER;
BEGIN
    codigo := 20;
    OPEN cur(codigo);
    FETCH cur INTO empls;
    
    dbms_output.put_line('El numero total de empleados del departamento '||codigo||' es '||empls);
END;



/* 4-Crear un bucle FOR donde declaramos una subconsulta que nos devuelva el
nombre de los empleados que sean ST_CLERCK. Es decir, no declaramos el
cursor sino que lo indicamos directamente en el FOR. */

BEGIN
    FOR i IN (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK') LOOP
        dbms_output.put_line(i.FIRST_NAME||' - '||i.JOB_ID);
    END LOOP;
END;

/* 5-Creamos un bloque que tenga un cursor para empleados. Debemos crearlo con
FOR UPDATE.
o Por cada fila recuperada, si el salario es mayor de 8000 incrementamos el
salario un 2%
o Si es menor de 800 lo hacemos en un 3%
o Debemos modificarlo con la cláusula CURRENT OF
o Comprobar que los salarios se han modificado correctamente. */

DECLARE
    CURSOR c1 IS SELECT * FROM EMPLOYEES FOR UPDATE;
    c NUMBER;
BEGIN
    c := 0;
    FOR i IN c1 LOOP
        IF i.SALARY > 8000 THEN
            UPDATE EMPLOYEES SET SALARY = SALARY * 1.02 WHERE CURRENT OF c1;
            c := c + 1;
        ELSIF i.SALARY < 800 THEN
            UPDATE EMPLOYEES SET SALARY = SALARY * 1.03 WHERE CURRENT OF c1;
            c := c + 1;
        END IF;
    END LOOP;
    COMMIT;
    dbms_output.put_line('Se modificaron los salarios de '||c||' empleados.');
END;
























