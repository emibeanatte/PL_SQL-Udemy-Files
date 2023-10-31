-- PAQUETE FACTURAS


CREATE OR REPLACE PACKAGE P_FACTURAS
IS
    PROCEDURE ALTA_FACTURA(CODIGO_F NUMBER, FECHA_F DATE, DESC_F VARCHAR2);
    PROCEDURE BAJA_FACTURA(CODIGO_F NUMBER);
    PROCEDURE MOD_DESCRI(CODIGO_F NUMBER, DESC_F VARCHAR2);
    PROCEDURE MOD_FECHA(CODIGO_F NUMBER, FECHA_F DATE);
    FUNCTION NUM_FACTURAS(FECHA_INICIO DATE, FECHA_FIN DATE) RETURN NUMBER;
    FUNCTION TOTAL_FACTURA(CODIGO_F NUMBER) RETURN NUMBER;
END P_FACTURAS;
/


CREATE OR REPLACE PACKAGE BODY P_FACTURAS AS

    FUNCTION f_exists(CODIGO_F NUMBER) RETURN BOOLEAN
    IS
        codigo FACTURAS.COD_FACTURA%TYPE;
    BEGIN
        SELECT COD_FACTURA INTO codigo
        FROM FACTURAS
        WHERE COD_FACTURAS = CODIGO_F;
    
        RETURN TRUE;
    
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
    END;


    PROCEDURE ALTA_FACTURA (CODIGO_F NUMBER, FECHA_F DATE, DESC_F VARCHAR2)
    AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F);
        IF factura_exists THEN
            RAISE_APPLICATION_ERROR(-20000,'La factura ya existe.');
        ELSE
            INSERT INTO FACTURAS
            VALUES (CODIGO_F, FECHA_F, DESC_F);
            COMMIT;
        END IF;
    
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;


    PROCEDURE BAJA_FACTURA(CODIGO_F NUMBER) AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F);
        IF factura_exists THEN
            DELETE FROM LINEAS_FACTURAS
            WHERE COD_FACTURA = CODIGO_F;
            
            DELETE FROM FACTURAS
            WHERE COD_FACTURA = CODIGO_F;
            
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'La factura que desea eliminar no existe.');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;
    
    PROCEDURE MOD_DESCRI(CODIGO_F NUMBER, DESC_F VARCHAR2) AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F);
        IF factura_exists THEN
            UPDATE FACTURA
            SET DESCRIPCION = DESC_F
            WHERE COD_FACTURA = CODIGO_F;
            
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'La factura que desea modificar no existe.');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;
    
    
    PROCEDURE MOD_FECHA(CODIGO_F NUMBER, FECHA_F DATE) AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F);
        IF factura_exists THEN
            UPDATE FACTURAS
            SET FECHA = FECHA_F
            WHERE COD_FACTURA = CODIGO_F;
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'La factura que desea modificar no existe.');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;
    

    
    FUNCTION NUM_FACTURAS(FECHA_INICIO DATE, FECHA_FIN DATE) RETURN NUMBER AS
        cont NUMBER;
    BEGIN
        cont := 0;
        
        SELECT COUNT(*) INTO cont
        FROM FACTURAS
        WHERE FECHA BETWEEN FECHA_INICIO AND FECHA_FIN;
        
        RETURN cont;
    END;
    
    
    FUNCTION TOTAL_FACTURA(CODIGO_F NUMBER) RETURN NUMBER AS
        total_f NUMBER;
    BEGIN
        SELECT SUM(PVP * UNIDADES) INTO total_f
        FROM LINEAS_FACTURA
        WHERE COD_FACTURA = CODIGO_F;
        
        RETURN total_f;
    END;
END P_FACTURAS;
/