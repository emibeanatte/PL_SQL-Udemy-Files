-- Práctica de COLECCIONES y RECORDS

/* • Creamos un TYPE RECORD que tenga las siguientes columnas
NAME VARCHAR2(100),
SAL EMPLOYEES.SALARY%TYPE,
COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);

• Creamos un TYPE TABLE basado en el RECORD anterior
• Mediante un bucle cargamos en la colección los empleados. El campo NAME
debe contener FIRST_NAME y LAST_NAME concatenado.
• Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el
vídeo usamos el EMPLOYEE_ID que va de 100 a 206
• A partir de este momento y ya con la colección cargada, hacemos las siguientes
operaciones, usando métodos de la colección.
• Visualizamos toda la colección
• Visualizamos el primer empleado
• Visualizamos el último empleado
• Visualizamos el número de empleados
• Borramos los empleados que ganan menos de 7000 y visualizamos de
nuevo la colección
• Volvemos a visualizar el número de empleados para ver cuantos se han
borrado */


SET SERVEROUTPUT ON

DECLARE
    TYPE empleado IS RECORD (
            name     VARCHAR2(100),
            sal      employees.salary%TYPE,
            cod_dept employees.department_id%TYPE
    );
    
    TYPE EMPLEADOS IS TABLE OF
        empleado 
    INDEX BY PLS_INTEGER;
   
    empls EMPLEADOS;
BEGIN
    FOR I IN 100..206 LOOP
        SELECT
            FIRST_NAME||' '||LAST_NAME, SALARY, DEPARTMENT_ID  
            INTO 
                empls(I)
        FROM
            EMPLOYEES
        WHERE 
            EMPLOYEE_ID = I;
    END LOOP;
    
    dbms_output.put_line('Coleccion completa: ');
    FOR I IN empls.FIRST..empls.LAST LOOP
        dbms_output.put_line(empls(I).name);
    END LOOP;
    
    
    dbms_output.put_line('Primer empleado: '||empls(empls.FIRST).name);
    dbms_output.put_line('Ultimo empleado: '||empls(empls.LAST).name);
    dbms_output.put_line('Numero de empleados: '||empls.COUNT);
    
    dbms_output.put_line('Borrarmos los empleados que ganan menos de 7000');
    FOR I IN empls.FIRST..empls.LAST LOOP
        IF empls(I).sal < 7000 THEN
            empls.DELETE(I);
        END IF;
    END LOOP;
    dbms_output.put_line('Numero de empleados: '||empls.COUNT);
END;

















