-- Practica comando IF

/* 1. PR�CTICA 1
� Debemos hacer un bloque PL/SQL an�nimo, donde declaramos una variable
NUMBER y la ponemos alg�n valor.
� Debe indicar si el n�mero es PAR o IMPAR. Es decir debemos usar IF..... ELSE
para hacer el ejercicio
� Como pista, recuerda que hay una funci�n en SQL denominada MOD, que
permite averiguar el resto de una divisi�n.
� Por ejemplo MOD(10,4) nos devuelve el resto de dividir 10 por 4. */


SET SERVEROUTPUT ON

DECLARE
    X NUMBER := 25;
BEGIN
    IF
        MOD(X,2) = 0
    THEN
        dbms_output.put_line('El numero es par');
    ELSE
        dbms_output.put_line('El numero es impar');
    END IF;
END;


/* 2. PR�CTICA 2
� Crear una variable CHAR(1) denominada TIPO_PRODUCTO.
� Poner un valor entre "A" Y "E"
� Visualizar el siguiente resultado seg�n el tipo de producto
o 'A' --> Electronica
o 'B' --> Inform�tica
o 'C' --> Ropa
o 'D' --> M�sica
o 'E' --> Libros
o Cualquier otro valor debe visualizar "El c�digo es incorrecto" */


DECLARE
    tipo CHAR(1) := 'B';
BEGIN
    IF
        tipo = 'A'
    THEN
        dbms_output.put_line('Electronica');
    ELSIF tipo = 'B' THEN
        dbms_output.put_line('Informatica');
    ELSIF tipo = 'C' THEN
        dbms_output.put_line('Ropa');
    ELSIF tipo = 'D' THEN
        dbms_output.put_line('M�sica');
    ELSIF tipo = 'E' THEN
        dbms_output.put_line('Libros');
    ELSE
        dbms_output.put_line('El c�digo es incorrecto');
    END IF;
END;























