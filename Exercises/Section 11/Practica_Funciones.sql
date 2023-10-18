--Práctica de FUNCIONES


/* 1. Crear una función que tenga como parámetro un número de
departamento y que devuelve la suma de los salarios de dicho
departamento. La imprimimos por pantalla.
• Si el departamento no existe debemos generar una excepción
con dicho mensaje
• Si el departamento existe, pero no hay empleados dentro,
también debemos generar una excepción para indicarlo
*/

CREATE OR REPLACE FUNCTION suma_salarios (
    depto IN EMPLOYEES.DEPARTMENT_ID%TYPE
)
RETURN NUMBER
IS
    suma NUMBER;
    dep DEPARTMENTS.DEPARTMENT_ID%TYPE;
    empls NUMBER;
BEGIN
    
    IF depto > 0 THEN
    
        SELECT DEPARTMENT_ID INTO dep
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = depto;
        
        SELECT COUNT(*) INTO empls
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = dep;
        
        IF empls > 0 THEN
        
            SELECT SUM(SALARY) INTO suma
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = dep;
        ELSE
            RAISE_APPLICATION_ERROR(-20098,'El departamento existe, pero no contiene empleados.');
        END IF;
    END IF;
    
    RETURN suma;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20056,'El departamento no existe');
END;
/

SET SERVEROUTPUT ON

DECLARE
    depto NUMBER;
    resultado NUMBER;
BEGIN
    depto:=20;
    resultado:= suma_salarios(depto);
    
    dbms_output.put_line('La suma de salarios del departamento '||depto||' es $ '||resultado);
END;
/        
            
            
/* 2. Modificar el programa anterior para incluir un parámetro de tipo OUT por
el que vaya el número de empleados afectados por la query. Debe ser
visualizada en el programa que llama a la función. De esta forma vemos
que se puede usar este tipo de parámetros también en una función   */ 
            
CREATE OR REPLACE FUNCTION suma_salarios (
    depto IN EMPLOYEES.DEPARTMENT_ID%TYPE,
    affected OUT NUMBER
)
RETURN NUMBER
IS
    suma NUMBER;
    dep DEPARTMENTS.DEPARTMENT_ID%TYPE;
    empls NUMBER;
BEGIN
    
    IF depto > 0 THEN
    
        SELECT DEPARTMENT_ID INTO dep
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = depto;
        
        SELECT COUNT(*) INTO empls
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID = dep;
        
        IF empls > 0 THEN
        
            SELECT SUM(SALARY), COUNT(SALARY) INTO suma, affected
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = dep
            GROUP BY DEPARTMENT_ID;
            
        ELSE
            RAISE_APPLICATION_ERROR(-20098,'El departamento existe, pero no contiene empleados.');
        END IF;
    END IF;
    
    RETURN suma;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20056,'El departamento no existe');
END;
/          
            
            
            
DECLARE
    depto NUMBER;
    resultado NUMBER;
    emp_aff NUMBER;
BEGIN
    depto:=20;
    resultado:= suma_salarios(depto,emp_aff);
    
    dbms_output.put_line('La suma de salarios del departamento '||depto||' es $ '||resultado);
    dbms_output.put_line('La cantidad de empleados registrados fueron: '||emp_aff);
END;
/


/* 3. Crear una función llamada CREAR_REGION,
• A la función se le debe pasar como parámetro un nombre de
región y debe devolver un número, que es el código de región
que calculamos dentro de la función
• Se debe crear una nueva fila con el nombre de esa REGION
• El código de la región se debe calcular de forma automática.
Para ello se debe averiguar cual es el código de región más
alto que tenemos en la tabla en ese momento, le sumamos 1 y
el resultado lo ponemos como el código para la nueva región
que estamos creando.
• Si tenemos algún problema debemos generar un error
• La función debe devolver el número que ha asignado a la región */

CREATE OR REPLACE FUNCTION CREAR_REGION (
    region_name IN VARCHAR2
)
RETURN NUMBER
IS
    max_id REGIONS.REGION_ID%TYPE;
    validate_name VARCHAR2(100);
BEGIN

    SELECT REGION_NAME INTO validate_name
    FROM REGIONS
    WHERE REGION_NAME = UPPER(region_name);
    
    RAISE_APPLICATION_ERROR(-20089,'La region ya existe.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        SELECT MAX(REGION_ID) INTO max_id
        FROM REGIONS;
    
        max_id := max_id + 1;
    
        INSERT INTO REGIONS (REGION_ID, REGION_NAME)
        VALUES (max_id, UPPER(region_name));
    
        RETURN max_id;    
END;
/

DECLARE
    id_region NUMBER;
BEGIN
    id_region := CREAR_REGION('El salvador');
    dbms_output.put_line('El id asignado a la nueva region es '||id_region);
END;
/
            
            
            
            
            
            
            
            
            
            
            
            
            
            
   
    

