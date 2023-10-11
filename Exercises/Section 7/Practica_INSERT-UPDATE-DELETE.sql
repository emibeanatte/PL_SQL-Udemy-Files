-- Practica INSERT, UPDATE, DELETE

/* 1- Crear un bloque que inserte un nuevo departamento en la tabla
DEPARTMENTS. Para saber el DEPARTMENT_ID que debemos asignar al
nuevo departamento primero debemos averiguar el valor mayor que hay en la
tabla DEPARTMENTS y sumarle uno para la nueva clave.
• Location_id debe ser 1000
• Manager_id debe ser 100
• Department_name debe ser “INFORMATICA”
• NOTA: en PL/SQL debemos usar COMMIT y ROLLBACK de la misma
forma que lo hacemos en SQL. Por tanto, para validar definitivamente un
cambio debemos usar COMMIT */


SET SERVEROUTPUT ON

DECLARE
    id_max NUMBER;
BEGIN
    SELECT
        MAX(DEPARTMENT_ID) INTO id_max
    FROM
        DEPARTMENTS;
        
    id_max := id_max + 1;
        
    INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
    VALUES (id_max, 'Programacion', 100, 1000);
    
    COMMIT;
END;


/* 2- Crear un bloque PL/SQL que modifique la LOCATION_ID del nuevo
departamento a 1700. En este caso usemos el COMMIT dentro del bloque
PL/SQL */


BEGIN
    UPDATE DEPARTMENTS
    SET LOCATION_ID = 1700
    WHERE DEPARTMENT_NAME = 'Programacion'; 
    COMMIT;
END;


-- 3- Por último, hacer otro bloque PL/SQL que elimine ese departamento nuevo.

BEGIN
    DELETE FROM DEPARTMENTS
    WHERE DEPARTMENT_NAME = 'Programacion';
    COMMIT;
END;


















        
