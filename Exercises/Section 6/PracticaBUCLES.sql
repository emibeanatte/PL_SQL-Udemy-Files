-- Practica Bucles

/* 1. Práctica 1
• Vamos a crear la tabla de multiplicar del 1 al 10, con los tres tipos de
bucles: LOOP, WHILE y FOR */

SET SERVEROUTPUT ON

-- LOOP

DECLARE
    num1 NUMBER;
    num2 NUMBER;
BEGIN
    num1 := 1;
    num2 := 1;
    
    LOOP
        EXIT WHEN num1 = 11;
        dbms_output.put_line('Tabla de multiplicar del ' || num1);
        
        LOOP
            EXIT WHEN num2 = 11;
            dbms_output.put_line(num1*num2);
            num2 := num2 + 1;
        END LOOP;
        
        num2 := 1;
        num1 := num1 + 1;
    END LOOP;
END;
/


-- WHILE

DECLARE
    num1 NUMBER;
    num2 NUMBER;
BEGIN
    num1 := 1;
    num2 := 1;
    
    WHILE num1 < 11 LOOP
        dbms_output.put_line('Tabla de multiplicar del ' || num1);
        
        WHILE num2 < 11 LOOP
            dbms_output.put_line(num1*num2);
            num2 := num2 + 1;
        END LOOP;
        
        num2 := 1;
        num1 := num1 + 1;
    END LOOP;
END;
/


-- FOR

BEGIN
    FOR i IN 1..10 LOOP
        dbms_output.put_line('Tabla de multiplicar del ' || i);
        
        FOR j IN 1..10 LOOP
            dbms_output.put_line(i * j);
        END LOOP;
    END LOOP;
END;
/


/* 2. Práctica 2-
• Crear una variable llamada TEXTO de tipo VARCHAR2(100).
• Poner alguna frase
• Mediante un bucle, escribir la frase al revés, Usamos el bucle WHILE */

DECLARE
    texto VARCHAR2(100) := 'Hello World';
    textoR VARCHAR2(100);
    len NUMBER;
BEGIN
    len := LENGTH(texto);
    
    WHILE len > 0 LOOP 
        textoR := textoR || SUBSTR(texto,len,1);
        len := len - 1;
    END LOOP;  
    
    dbms_output.put_line(textoR);
END;
/


/* 3. Práctica 3
• Usando la práctica anterior, si en el texto aparece el carácter "x" debe
salir del bucle. Es igual en mayúsculas o minúsculas.
• Debemos usar la cláusula EXIT */


DECLARE
    texto VARCHAR2(100) := 'Welcome to SpaceX, Elon Musk.';
    textoR VARCHAR2(100);
    len NUMBER;
BEGIN
    len := LENGTH(texto);
    
    WHILE len > 0 LOOP
        EXIT WHEN UPPER(SUBSTR(texto,len,1)) = 'X';
        textoR := textoR || SUBSTR(texto,len,1);
        len := len - 1;   
    END LOOP;  
    
    dbms_output.put_line(textoR);
END;
/
    
    
/* 4. Práctica 4
• Debemos crear una variable llamada NOMBRE
• Debemos pintar tantos asteriscos como letras tenga el nombre.
Usamos un bucle FOR
• Por ejemplo Alberto ? *******
• O por ejemplo Pedro ? ***** 
*/

DECLARE
    nombre VARCHAR2(50) := 'Emiliano';
    resultado VARCHAR(50);
BEGIN
    
    FOR i IN 1..LENGTH(nombre) LOOP 
        resultado := resultado || '*';
    END LOOP;  
    dbms_output.put_line(nombre ||
            ' '
            || '-> '
            || resultado);  
END;
/



/* 5. Práctica 5
• Creamos dos variables numéricas, "inicio y fin"
• Las inicializamos con algún valor:
• Debemos sacar los números que sean múltiplos de 4 de ese rango */

DECLARE
    inicio NUMBER;
    fin NUMBER;
BEGIN
    inicio := 2;
    fin := 20;
    
    dbms_output.put_line('Numeros multiplos de 4: ');
    FOR i IN inicio..fin LOOP
    
        IF
            MOD(i,4) = 0
        THEN
            dbms_output.put_line(i);
        END IF;
    END LOOP;  
END;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    