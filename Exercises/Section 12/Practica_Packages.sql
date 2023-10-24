-- Práctica de PAQUETES

/* 1. Crear un paquete denominado REGIONES que tenga los
siguientes componentes:

• PROCEDIMIENTOS:
• - ALTA_REGION, con parámetro de código y nombre Región.
Debe devolver un error si la región ya existe. Inserta una nueva
región en la tabla. Debe llamar a la función EXISTE_REGION
para controlarlo.
• - BAJA_REGION, con parámetro de código de región y que
debe borrar una región. Debe generar un error si la región no
existe, Debe llamar a la función EXISTE_REGION para
controlarlo
• - MOD_REGION: se le pasa un código y el nuevo nombre de la
región Debe modificar el nombre de una región ya existente.
Debe generar un error si la región no existe, Debe llamar a la
función EXISTE_REGION para controlarlo

• FUNCIONES
• CON_REGION. Se le pasa un código de región y devuelve el
nombre
• EXISTE_REGION. Devuelve verdadero si la región existe. Se
usa en los procedimientos y por tanto es PRIVADA, no debe
aparecer en la especificación del paquete
*/

SET SERVEROUTPUT ON

CREATE OR REPLACE PACKAGE REGIONES
IS
    PROCEDURE ALTA_REGION(codigo NUMBER, nombre VARCHAR2);
    PROCEDURE BAJA_REGION(codigo NUMBER);
    PROCEDURE MOD_REGION(codigo NUMBER, new_nombre VARCHAR2);
    FUNCTION CON_REGION(codigo NUMBER) RETURN VARCHAR2;
END REGIONES;
/


CREATE OR REPLACE PACKAGE BODY REGIONES
IS
    FUNCTION EXISTE_REGION(codigo NUMBER, nombre VARCHAR2) RETURN BOOLEAN
    IS
        reg_exists REGIONS%ROWTYPE;
    BEGIN
        SELECT 1 INTO reg_exists
        FROM REGIONS
        WHERE REGION_ID = codigo
            AND REGION_NAME = nombre;
        
        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END EXISTE_REGION;
    

    PROCEDURE ALTA_REGION(codigo NUMBER, nombre VARCHAR2)
    IS
    BEGIN
        IF EXISTE_REGION(codigo, nombre) THEN
            RAISE_APPLICATION_ERROR(-20079,'La region ya existe.');
        ELSE
            INSERT INTO REGIONS (REGION_ID, REGION_NAME)
            VALUES (codigo, nombre);
        END IF;
    END ALTA_REGION;
    
    
    PROCEDURE BAJA_REGION(codigo NUMBER)
    IS
        nombre VARCHAR2(100);
    BEGIN
        SELECT REGION_NAME INTO nombre
        FROM REGIONS
        WHERE REGION_ID = codigo;
        
        IF EXISTE_REGION(codigo, nombre) THEN
            DELETE FROM REGIONS
            WHERE REGION_ID = codigo;
            
            dbms_output.put_line('Region eliminada');
        ELSE
            RAISE_APPLICATION_ERROR(-20079,'La region a eliminar no existe.');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('La region no existe');
    END BAJA_REGION;
    
    
    PROCEDURE MOD_REGION(codigo NUMBER, new_nombre VARCHAR2)
    IS
    BEGIN
        IF EXISTE_REGION(codigo, new_nombre) THEN
            UPDATE REGIONS
            SET REGION_NAME = new_nombre
            WHERE REGION_ID = codigo;
        ELSE
            RAISE_APPLICATION_ERROR(-20079,'La region ya existe.');
        END IF;
    END MOD_REGION;
    
    FUNCTION CON_REGION(codigo NUMBER) 
    RETURN VARCHAR2
    IS
        reg_name VARCHAR2(100);
    BEGIN
        SELECT REGION_NAME INTO reg_name
        FROM REGIONS
        WHERE REGION_ID = codigo;
        
        RETURN reg_name;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('La region no existe');
            RETURN NULL;
    END CON_REGION;
     
END;
/     
        

EXECUTE REGIONES.ALTA_REGION(6,'Colombia');
EXECUTE REGIONES.BAJA_REGION(5);
EXECUTE REGIONES.MOD_REGION(6,'Japon');

DECLARE
    nombre VARCHAR2(100);
BEGIN
    nombre := REGIONES.CON_REGION(6);
    dbms_output.put_line(nombre);
END;
/



/* 2. Crear un paquete denominado NOMINA que tenga sobrecargado
la función CALCULAR_NOMINA de la siguiente forma:
• CALCULAR_NOMINA(NUMBER): se calcula el salario del
empleado restando un 15% de IRPF.
• CALCULAR_NOMINA(NUMBER,NUMBER): el segundo
parámetro es el porcentaje a aplicar. Se calcula el salario del
empleado restando ese porcentaje al salario
• CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo
parámetro es el porcentaje a aplicar, el tercero vale ‘V’ . Se
calcula el salario del empleado aumentando la comisión que le
pertenece y restando ese porcentaje al salario siempre y
cuando el empleado tenga comisión. */

CREATE OR REPLACE PACKAGE NOMINA
IS
    FUNCTION CALCULAR_NOMINA(emp NUMBER) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(emp NUMBER, ptj VARCHAR2) RETURN NUMBER;
    FUNCTION CALCULAR_NOMINA(emp NUMBER, ptj VARCHAR2, comision VARCHAR2 := 'V') RETURN NUMBER;
END NOMINA;
/

CREATE OR REPLACE PACKAGE BODY NOMINA
IS
    FUNCTION CALCULAR_NOMINA(emp NUMBER) RETURN NUMBER
    IS
        salario NUMBER;
        resultado NUMBER;
    BEGIN
        SELECT SALARY INTO salario
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = emp;
        
        resultado := salario - (salario * 0.15);
        
        RETURN resultado;
    END;
    
    
    FUNCTION CALCULAR_NOMINA(emp NUMBER, ptj VARCHAR2) RETURN NUMBER
    IS
        salario NUMBER;
        resultado NUMBER;
    BEGIN
        SELECT SALARY INTO salario  
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = emp;
        
        resultado := salario - (salario *  (TO_NUMBER(ptj) / 100 ));
        RETURN resultado;
    END;

    
    FUNCTION CALCULAR_NOMINA(emp NUMBER, ptj NUMBER, comision VARCHAR2 := 'V') RETURN NUMBER
    IS
        salario NUMBER;
        commission NUMBER;
        resultado NUMBER;
    BEGIN
        SELECT SALARY INTO salario
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = emp;
        
        SELECT COMMISSION_PCT INTO commission
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = emp;
        
        resultado := salario - (salario * (TO_NUMBER(ptj) / 100 )) + (salario * commission);
        RETURN resultado;
    END;
END NOMINA;
/

DECLARE
    x NUMBER;
BEGIN
    x := NOMINA.CALCULAR_NOMINA(150);
    DBMS_OUTPUT.PUT_LINE(x);
END;
/

































