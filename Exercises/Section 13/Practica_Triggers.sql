-- Practica TRIGGERS    


/* 1. Crear un TRIGGER BEFORE DELETE sobre la tabla EMPLOYEES que
impida borrar un registro si su JOB_ID es algo relacionado con CLERK
*/

CREATE OR REPLACE TRIGGER trg_clerk
BEFORE DELETE ON EMPLOYEES
FOR EACH ROW
BEGIN
    IF :OLD.JOB_ID LIKE '%CLERK' THEN
        RAISE_APPLICATION_ERROR(-20000,'No se puede borrar empleados con ese JOB_ID');
    END IF;
END trg_clerk;
/

DELETE FROM EMPLOYEES
WHERE JOB_ID LIKE '%CLERK';


/* 2. Crear una tabla denominada AUDITORIA con las siguientes columnas:
CREATE TABLE AUDITORIA (
USUARIO VARCHAR(50),
FECHA DATE,
SALARIO_ANTIGUO NUMBER,
SALARIO_NUEVO NUMBER);
3. Crear un TRIGGER BEFORE INSERT de tipo STATEMENT, de forma que
cada vez que se haga un INSERT en la tabla REGIONS guarde una fila
en la tabla AUDITORIA con el usuario y la fecha en la que se ha hecho el
INSERT
*/


CREATE TABLE AUDITORIA (
    USUARIO VARCHAR2(50),
    FECHA DATE,
    SALARIO_ANTIGUO NUMBER,
    SALARIO_NUEVO NUMBER
);
/

CREATE OR REPLACE TRIGGER trg_aud
BEFORE INSERT ON REGIONS
BEGIN
    INSERT INTO AUDITORIA (USUARIO, FECHA)
    VALUES (USER,SYSDATE);
END;
/

INSERT INTO REGIONS VALUES (20,'TEST');

SELECT * 
FROM AUDITORIA;


/* 4. Realizar otro trigger BEFORE UPDATE de la columna SALARY de tipo
EACH ROW.
• Si la modificación supone rebajar el salario el TRIGGER debe
disparar un RAISE_APPLICATION_FAILURE “no se puede bajar
un salario”.
• Si el salario es mayor debemos dejar el salario antiguo y el salario
nuevo en la tabla AUDITORIA.*/

CREATE OR REPLACE TRIGGER trg_aud
BEFORE UPDATE OF SALARY ON EMPLOYEES
FOR EACH ROW
BEGIN
    IF :NEW.SALARY < :OLD.SALARY THEN
        RAISE_APPLICATION_ERROR(-20000,'No se puede bajar un salario');
    ELSIF :NEW.SALARY >= :OLD.SALARY THEN
        INSERT INTO AUDITORIA (USUARIO, FECHA, SALARIO_ANTIGUO, SALARIO_NUEVO)
        VALUES (USER, SYSDATE, :OLD.SALARY, :NEW.SALARY);
    END IF;
END trg_aud;
/

UPDATE EMPLOYEES
SET SALARY = 30000
WHERE EMPLOYEE_ID = 100;


SELECT *
FROM AUDITORIA;


/* 5. Crear un TRIGGER BEFORE INSERT en la tabla DEPARTMENTS que al
insertar un departamento compruebe que el código no esté repetido y
luego que si el LOCATION_ID es NULL le ponga 1700 y si el
MANAGER_ID es NULL le ponga 200
*/

CREATE OR REPLACE TRIGGER trg_dpt
BEFORE INSERT ON DEPARTMENTS
FOR EACH ROW
DECLARE
    code DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_ID INTO code
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID = :NEW.DEPARTMENT_ID;
    
    RAISE_APPLICATION_ERROR(-20000,'El departamento ya existe.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        IF :NEW.LOCATION_ID IS NULL THEN
            :NEW.LOCATION_ID := 1700;
        END IF;
        
        IF :NEW.MANAGER_ID IS NULL THEN
            :NEW.MANAGER_ID := 200;
        END IF;
END trg_dpt;
/


INSERT INTO DEPARTMENTS VALUES (300, 'Finanzas', NULL, NULL);
COMMIT;


SELECT *
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 300;



































