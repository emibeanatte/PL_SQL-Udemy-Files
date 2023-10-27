-- JSON EN PL/SQL

SET SERVEROUTPUT ON

DECLARE
    c1 VARCHAR2(400);
BEGIN
    SELECT P1.DATOS.Pais INTO c1
    FROM PRODUCTOS1 P1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(c1);
END;
/

-- FUNCIONES JSON EN PL/SQL

DECLARE
    c1 VARCHAR2(400);
BEGIN
    SELECT P1.DATOS.Poblacion INTO c1
    FROM PRODUCTOS1 P1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(c1); -- 1500000
    
    -- JSON VALUE
    SELECT JSON_VALUE(P1.DATOS, '$.Pais') INTO c1
    FROM PRODUCTOS1 P1
    WHERE CODIGO = 1;
    
    dbms_output.put_line(c1); -- Argentina
    
    SELECT JSON_VALUE(P1.DATOS, '$.Direccion.Calle') INTO c1
    FROM PRODUCTOS1 P1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(c1); -- xcxxxx
    
    -- JSON QUERY
    SELECT JSON_QUERY(P1.DATOS, '$.Direccion') INTO c1
    FROM PRODUCTOS1 P1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(c1); -- {"Calle":"xcxxxx","Piso":5,"Puerta":"C"}
    
    -- JSON TRANSFORM
    SELECT JSON_TRANSFORM(DATOS, RENAME '$.Poblacion' = 'pob') INTO c1
    FROM PRODUCTOS1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(c1); -- .... "pob":1500000}
    
END;
/


-- Metodos

DECLARE
    json1 JSON_OBJECT_T;
    var1 VARCHAR2(4000);
BEGIN
    
        -- Constructor
        json1 := JSON_OBJECT_T.PARSE('{"nombre":"alberto"}'); 
        dbms_output.put_line(json1.TO_STRING);
        
        -- PUT
        -- escalares
        json1.PUT('edad', 25);
        dbms_output.put_line(json1.TO_STRING);
        
        json1.PUT('telefono', '55509872');
        dbms_output.put_line(json1.TO_STRING);
        
        
        -- Documento anidado
        json1.PUT('direccion',JSON_OBJECT_T('{"calle":"Estrada","numero":"885","ciudad":"madrid"}'));
        dbms_output.put_line(json1.TO_STRING);
        
        
        -- ARRAY
        json1.PUT('experiencia', JSON_ARRAY_T('["java","oracle","mysql","spring"]'));
        dbms_output.put_line(json1.TO_STRING);
        
        dbms_output.put_line(' ');
        
        -- Actualizar dato
        json1.put('edad',45);
        dbms_output.put_line(json1.to_string);
  
        -- Renombrar clave
        json1.rename_key('nombre','nombre_completo');
        dbms_output.put_line(json1.to_string);
  
        -- Eliminar un elemento
        json1.remove('telefono');
        dbms_output.put_line(json1.to_string);
        
        dbms_output.put_line(' ');
        
        -- Serializacion - metodos get
        -- Recuperar valores concretos        
        var1 := json1.get_string('nombre_completo');
        dbms_output.put_line(var1);
        
        var1 := json1.get_number('edad');
        dbms_output.put_line(var1);
        
        var1 := json1.get_object('direccion').get_string('calle');
        dbms_output.put_line(var1);
        
        
        
END;
/


-- Trabajar con base de datos

DECLARE
    json1 JSON_OBJECT_T;
    var1 VARCHAR2(4000);
    resultado VARCHAR2(4000);
BEGIN

    SELECT DATOS INTO var1
    FROM PRODUCTOS1
    WHERE CODIGO = 2;
    
    dbms_output.put_line(var1);
    
    json1 := JSON_OBJECT_T(var1);
    dbms_output.put_line(json1.to_string);
    
    json1.put('columna', 'test');
    resultado := json1.to_string;
    
    UPDATE PRODUCTOS1
    SET DATOS = resultado
    WHERE CODIGO = 2;

END;
/


SELECT DATOS FROM PRODUCTOS1 WHERE CODIGO = 2;



-- Arrays

DECLARE
    json1 JSON_ARRAY_T;
    var1 VARCHAR2(4000);
BEGIN
    json1 := JSON_ARRAY_T('["bmw","mercedes","citroen"]');
    dbms_output.put_line(json1.to_string);
    
    -- Length
    dbms_output.put_line(json1.get_size);
    
    -- Recuperar un valor del array
    dbms_output.put_line(json1.get(0).to_string);
    
    
    -- Recuperar todos los elementos
    FOR i IN 0..json1.get_size - 1 LOOP
        dbms_output.put_line(json1.get(i).to_string);
    END LOOP;
    
    -- Array de documentos
    json1 := JSON_ARRAY_T('[
                            {"ciudad":"Madrid",
                            "concesionario":["bmw","mercedes","citroen"]
                            },
                            {"ciudad":"Valencia",
                            "concesionario":["honda","kia","audi"]}
                            ]');
    
    -- Length
    dbms_output.put_line(json1.get_size);

    -- Recuperar un valor del array
    dbms_output.put_line(json1.get(0).to_string);

    -- Recuperar todos los elementos
    FOR i IN 0..json1.get_size - 1 LOOP
        dbms_output.put_line(json1.get(i).to_string);
    END LOOP;
END;
/


-- Otras Operaciones

DECLARE
    json1 JSON_ARRAY_T;
    var1 VARCHAR(4000);
BEGIN
    -- Crear el array
    json1:=json_array_t('["bmw","mercedes","citroen"]');

    -- Añadir un elemento
    json1.append('ford');
    dbms_output.put_line(json1.to_string);

    -- Añadir un nulo
    json1.append_null;
    dbms_output.put_line(json1.to_string);

    -- Poner un valor en una determinada posición
    json1.put(2,'renault');
    dbms_output.put_line(json1.to_string);
 
    -- Eliminar un elemento
    json1.remove(3);
    dbms_output.put_line(json1.to_string);
   
    -- Poner un array
    json1.put(3,json_array_t('["f1","f2","f3"]'));
    dbms_output.put_line(json1.to_string);

    -- Añadir un subdocumento
    json1.append(json_element_t.parse('{"nombre":"alberto","apellidos":"perez Rodriguez"}'));
    dbms_output.put_line(json1.to_string);
END;
/