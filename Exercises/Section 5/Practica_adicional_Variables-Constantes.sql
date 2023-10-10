--  Práctica adicional Variables y Constantes

/* • Queremos calcular el impuesto de un producto

    o El impuesto será del 21%. Le debemos poner en una constante
    o Creamos una variable de tipo number (5,2) para poner el precio del
     producto
    o Creamos otra variable para el resultado. Le decimos que es del
     mismo tipo (type) que la anterior
    o Hacemos el cálculo y visualizamos el resultado.
    
*/

SET SERVEROUTPUT ON

DECLARE
    imp       CONSTANT NUMBER := 21;
    precio    NUMBER(5, 2);
    resultado precio%TYPE;
BEGIN
    precio := 200;
    resultado := ( precio * imp ) / 100;
    dbms_output.put_line('El impuesto es de: ' || resultado);
END;