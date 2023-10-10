-- Practica comando IF

/* 1. PRÁCTICA 1
• Debemos hacer un bloque PL/SQL anónimo, donde declaramos una variable
NUMBER y la ponemos algún valor.
• Debe indicar si el número es PAR o IMPAR. Es decir debemos usar IF..... ELSE
para hacer el ejercicio
• Como pista, recuerda que hay una función en SQL denominada MOD, que
permite averiguar el resto de una división.
• Por ejemplo MOD(10,4) nos devuelve el resto de dividir 10 por 4. */


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


/* 2. PRÁCTICA 2
• Crear una variable CHAR(1) denominada TIPO_PRODUCTO.
• Poner un valor entre "A" Y "E"
• Visualizar el siguiente resultado según el tipo de producto
o 'A' --> Electronica
o 'B' --> Informática
o 'C' --> Ropa
o 'D' --> Música
o 'E' --> Libros
o Cualquier otro valor debe visualizar "El código es incorrecto" */


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
        dbms_output.put_line('Música');
    ELSIF tipo = 'E' THEN
        dbms_output.put_line('Libros');
    ELSE
        dbms_output.put_line('El código es incorrecto');
    END IF;
END;























