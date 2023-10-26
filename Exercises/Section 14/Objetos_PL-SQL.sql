-- Objetos en PL SQL

-- CREAR UN OBJETO

CREATE OR REPLACE TYPE PRODUCTO AS OBJECT (

    -- ATRIBUTOS
    codigo NUMBER,
    nombre VARCHAR2(100),
    precio  NUMBER,

    -- METODOS
    MEMBER FUNCTION ver_producto RETURN VARCHAR2,
    MEMBER FUNCTION ver_precio RETURN NUMBER,
    MEMBER FUNCTION ver_precio(impuestos NUMBER) RETURN NUMBER,
    MEMBER PROCEDURE cambiar_precio(precio NUMBER),
    STATIC PROCEDURE auditoria,
    CONSTRUCTOR FUNCTION PRODUCTO (nombre VARCHAR2) RETURN SELF AS RESULT
) NOT FINAL;
/

-- CREAR EL CUERPO DEL OBJETO

CREATE OR REPLACE TYPE BODY PRODUCTO AS
    MEMBER FUNCTION ver_producto RETURN VARCHAR2 AS
    BEGIN
        RETURN 'Codigo: '||codigo||', nombre: '||nombre||', precio: '||precio;
    END ver_producto;

    MEMBER FUNCTION ver_precio RETURN NUMBER AS
    BEGIN
        RETURN precio;
    END ver_precio;
    
    MEMBER FUNCTION ver_precio(impuestos NUMBER) RETURN NUMBER AS
    BEGIN
        RETURN precio - (precio * (impuestos / 100));
    END;

    MEMBER PROCEDURE cambiar_precio(precio NUMBER) AS
    BEGIN
        SELF.precio := precio;
    END cambiar_precio;
    
    STATIC PROCEDURE auditoria AS
    BEGIN
        INSERT INTO auditoria VALUES(USER, SYSDATE);
    END;
    
    CONSTRUCTOR FUNCTION PRODUCTO (nombre VARCHAR2) RETURN SELF AS RESULT
    IS
    BEGIN
        self.nombre := nombre;
        self.precio := NULL;
        self.codigo := SEQ1.NEXTVAL;
        RETURN;
    END;
END;
/

-- HERENCIA

CREATE OR REPLACE TYPE COMESTIBLES UNDER PRODUCTO (
    caducidad date,
    
    MEMBER FUNCTION ver_caducidad RETURN VARCHAR2,
    -- SOBREESCRIBIR METODOS DEL PADRE
    OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER
);
/


-- BODY DEL OBJETO HIJO
CREATE OR REPLACE TYPE BODY COMESTIBLES AS 
    MEMBER FUNCTION ver_caducidad RETURN VARCHAR2 AS
    BEGIN
        RETURN caducidad;
    END;
    
    OVERRIDING MEMBER FUNCTION ver_precio RETURN NUMBER AS
    BEGIN
        RETURN precio + 10;
    END;
END;
/


-- PROBAMOS EL OBJETO

SET SERVEROUTPUT ON FORMAT WRAPPED LINE 1000;

DECLARE
    --var1 PRODUCTO;
    --var2 PRODUCTO;
    var3 COMESTIBLES;
BEGIN
    --var1 := PRODUCTO(100,'Producto1',10);  
    /*dbms_output.put_line(var1.ver_producto());
    var1.cambiar_precio(50);
    dbms_output.put_line(var1.ver_precio()); 
    
    -- METODO STATIC
    PRODUCTO.auditoria();*/
    
    -- PROBAMOS EL OTRO CONSTRUCTOR
    /*var2 := PRODUCTO('Producto2');
    dbms_output.put_line(var2.ver_producto());*/
    
    -- PROBAMOS LOS METODOS SOBRECARGADOS
    /*dbms_output.put_line(var1.ver_precio());
    dbms_output.put_line(var1.ver_precio(10));*/
    
    -- PROBAMOS EL OBJETO HIJO
    var3 := COMESTIBLES(900,'Caramelos', 20, SYSDATE());
    
    dbms_output.put_line(var3.ver_precio);
    dbms_output.put_line(var3.ver_precio(10));
    dbms_output.put_line(var3.ver_caducidad);
    
END;
/

-- COLUMNAS OBJETO EN UNA TABLA
CREATE TABLE TIENDA (
    codigo NUMBER,
    estanteria NUMBER,
    producto PRODUCTO
);

INSERT INTO TIENDA VALUES (1,1,PRODUCTO(1,'Limon','90'));

SELECT t.codigo, t.estanteria, t.producto.ver_producto() AS "PRODUCTO"
FROM TIENDA t;




















