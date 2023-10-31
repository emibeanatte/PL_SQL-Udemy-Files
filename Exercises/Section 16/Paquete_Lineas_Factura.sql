-- PAQUETE LINEA_FACTURAS

CREATE OR REPLACE PACKAGE P_LINEAS_FACTURA
IS
    PROCEDURE ALTA_LINEA(CODIGO_F NUMBER, CODIGO_P NUMBER, UNIDADES_P NUMBER, FECHA_F DATE);
    PROCEDURE BAJA_LINEA(CODIGO_F NUMBER, CODIGO_P NUMBER);
    PROCEDURE MOD_PRODUCTO(CODIGO_F NUMBER, CODIGO_P NUMBER, UNIDADES_P NUMBER);
    PROCEDURE MOD_PRODUCTO(CODIGO_F NUMBER, CODIGO_P NUMBER, FECHA_F DATE);
    FUNCTION NUM_LINEAS(CODIGO_F NUMBER)RETURN NUMBER;
END;
/


CREATE OR REPLACE PACKAGE BODY P_LINEAS_FACTURA
AS
    FUNCTION f_exists(CODIGO_F NUMBER, CODIGO_P NUMBER) RETURN BOOLEAN IS
        codigo LINEAS_FACTURAS.COD_FACTURA%TYPE;
    BEGIN
        SELECT COD_FACTURA INTO codigo
        FROM LINEAS_FACTURA
        WHERE COD_FACTURA = CODIGO_F AND COD_PRODUCTO = CODIGO_P;
        
        RETURN TRUE;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN FALSE;
    END;
    
    
    PROCEDURE ALTA_LINEA(CODIGO_F NUMBER, CODIGO_P NUMBER, UNIDADES_P NUMBER, FECHA_F DATE)
    AS
        factura_exists BOOLEAN;
        pvp_p NUMBER;
    BEGIN
        factura_exists := f_exists(CODIGO_F, CODIGO_P);
        IF factura_exists THEN
            RAISE_APPLICATION_ERROR(-20000,'La factura o el producto ya existe.');
        ELSE
            SELECT PVP INTO pvp_p
            FROM PRODUCTOS
            WHERE COD_PRODUCTO = CODIGO_P;
            
            INSERT INTO LINEAS_FACTURAS
            VALUES (CODIGO_F, CODIGO_P, pvp_p, UNIDADES_P, FECHA_F);
            
            COMMIT;
        END IF;
        
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20000,'El producto no existe.');
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR('Error inesperado');
    END;
    
    
    PROCEDURE BAJA_LINEA(CODIGO_F NUMBER, CODIGO_P NUMBER) 
    AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F, CODIGO_P);
        IF factura_exists THEN
            DELETE FROM LINEAS_FACTURA
            WHERE COD_FACTURA = CODIGO_F
                AND COD_PRODUCTO = CODIGO_P;
            
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'El producto o factura que desea eliminar no existe');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;


    PROCEDURE MOD_PRODUCTO(CODIGO_F NUMBER, CODIGO_P NUMBER, UNIDADES_P NUMBER)
    AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F, CODIGO_P);
        IF factura_exists THEN
            UPDATE LINEAS_FACTURA L
            SET UNIDADES = UNIDADES_P,
                PVP = (SELECT PVP FROM PRODUCTOS WHERE COD_PRODUCTO = L.COD_PRODUCTO)
            WHERE COD_FACTURA = CODIGO_F
                AND COD_PRODUCTO = CODIGO_P;
            
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'El producto que desea modificar no existe');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;
    
    
     
     PROCEDURE MOD_PRODUCTO(CODIGO_F NUMBER, CODIGO_P NUMBER, FECHA_F DATE)
     AS
        factura_exists BOOLEAN;
    BEGIN
        factura_exists := f_exists(CODIGO_F, CODIGO_P);
        IF factura_exists THEN
            UPDATE LINEAS_FACTURA
            SET FECHA = FECHA_F
            WHERE COD_FACTURA = CODIGO_F
                AND COD_PRODUCTO = CODIGO_P;
            
            COMMIT;
        ELSE
            RAISE_APPLICATION_ERROR(-20000,'El producto que desea modificar no existe');
        END IF;
        
        EXCEPTION
            WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20000,'Error inesperado');
    END;

    
    FUNCTION NUM_LINEAS(CODIGO_F NUMBER)RETURN NUMBER AS
        cont NUMBER;
    BEGIN
        cont := 0;
        SELECT COUNT(*) INTO cont
        FROM LINEAS_FACTURA
        WHERE COD_FACTURA = CODIGO_F;
        
        RETURN cont;
    END;
END P_LINEAS_FACTURA;
/