-- Practica SELECT INTO

/* 1. PR�CTICA 1
� Crear un bloque PL/SQL que devuelva al salario m�ximo del
departamento 100 y lo deje en una variable denominada salario_maximo
y la visualice */

SET SERVEROUTPUT ON

DECLARE
    max_salary EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT
        MAX(SALARY) INTO max_salary
    FROM
        EMPLOYEES
    WHERE
        DEPARTMENT_ID = 100;
        
    dbms_output.put_line('El salario maximo del departamento 100 es ' || max_salary);
END;
/

/* 2. PR�CTICA2
� Visualizar el tipo de trabajo del empleado n�mero 100 */

DECLARE
    job_type EMPLOYEES.JOB_ID%TYPE;
BEGIN
    SELECT
        JOB_ID INTO job_type
    FROM
        EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    dbms_output.put_line('El tipo de trabajo es: ' || job_type);
END;
/

/* 3. PR�CTICA 3
� Crear una variable de tipo DEPARTMENT_ID y ponerla alg�n valor, por
ejemplo 10.
� Visualizar el nombre de ese departamento y el n�mero de empleados
que tiene, poniendo. Crear dos variables para albergar los valores.
 */
 
DECLARE
    dept_id DEPARTMENTS.DEPARTMENT_ID%TYPE := 50;
    dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    dept_emp_num NUMBER;
BEGIN
    SELECT
        DEPARTMENT_NAME INTO dept_name
    FROM
        DEPARTMENTS
    WHERE
        DEPARTMENT_ID = dept_id;
        
    SELECT
        COUNT(*) INTO dept_emp_num
    FROM
        EMPLOYEES
    WHERE 
        DEPARTMENT_ID = dept_id;
        
    dbms_output.put_line('El departamento ' || dept_name || ' tiene ' || dept_emp_num || ' empleados.');
END;


/* 4. PR�CTICA 4
� Mediante dos consultas recuperar el salario m�ximo y el salario m�nimo
de la empresa e indicar su diferencia */


DECLARE
    max_salary EMPLOYEES.SALARY%TYPE;
    min_salary EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT
        MAX(SALARY) INTO max_salary
    FROM
        EMPLOYEES;
        
    SELECT
        MIN(SALARY) INTO min_salary
    FROM 
        EMPLOYEES;
        
    dbms_output.put_line('La diferencia entre el salario maximo y el minimo es ' || (max_salary - min_salary));
END;
        
    
 


































