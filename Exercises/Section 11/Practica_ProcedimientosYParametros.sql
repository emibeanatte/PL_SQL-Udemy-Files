-- Práctica de PROCEDIMIENTOS Y PARÁMETROS

/* 1- Crear un procedimiento llamado “visualizar” que visualice el nombre y
    salario de todos los empleados. */

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE visualizar 
IS
    CURSOR cur IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES;
BEGIN
    FOR i IN cur LOOP
        dbms_output.put_line('Nombre: '|| i.FIRST_NAME || ' - Salario: ' || i.SALARY);
    END LOOP;
END;
/
    
EXECUTE visualizar;


/* 2- Modificar el programa anterior para incluir un parámetro que pase el
número de departamento para que visualice solo los empleados de ese
departamento
• Debe devolver el número de empleados en una variable de tipo OUT */

CREATE OR REPLACE PROCEDURE visualizar (
    dept IN EMPLOYEES.DEPARTMENT_ID%TYPE,
    empls OUT NUMBER
)
IS
    CURSOR cur IS SELECT FIRST_NAME, SALARY 
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = dept; 
BEGIN
    empls := 0;
    FOR i IN cur LOOP
        dbms_output.put_line('Nombre: '|| i.FIRST_NAME || ' - Salario: ' || i.SALARY);
        empls := empls + 1;
    END LOOP;  
END;
/
    

DECLARE
    x NUMBER;
    d EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    d := 80;
    visualizar(d,x);
    dbms_output.put_line('El numero de empleados del departamento '|| d || ' es ' || x);
END;
/

/* 3- Crear un bloque por el cual se de formato a un número de cuenta
suministrado por completo, por ejmplo: 11111111111111111111
• Formateado a: 1111-1111-11-1111111111
• Debemos usar un parámetro de tipo IN-OUT */

CREATE OR REPLACE PROCEDURE formatear (acc_num IN OUT
VARCHAR2)
IS
    f1 VARCHAR2(20);
    f2 VARCHAR2(20);
    f3 VARCHAR2(20);
    f4 VARCHAR2(20);
BEGIN
    f1:= SUBSTR(acc_num,1,4);
    f2:= SUBSTR(acc_num,5,4);
    f3:= SUBSTR(acc_num,9,2);
    f4:= SUBSTR(acc_num,10);
    acc_num := f1 || '-' || f2 || '-' || f3 || '-' || f4;
END;
/
    

DECLARE
    cuenta VARCHAR2(100);
BEGIN
    cuenta := '11111111111111111111';
    formatear(cuenta);
    dbms_output.put_line('Cuenta formateada: ' || cuenta);
END;
/

































    





