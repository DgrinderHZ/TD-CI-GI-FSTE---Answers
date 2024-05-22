SET serveroutput ON;

-- Exercice 1a :
DECLARE
    x CHAR(20);
BEGIN
    x := 'Hello World';
    DBMS_OUTPUT.PUT_LINE(x);
END;
/

-- Exercice 1b :
DECLARE
    v_nbrComidies NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_nbrComidies 
    FROM FILM f 
    JOIN GENREFILM gf 
    ON f.numFilm = gf.numFilm 
    WHERE gf.codeGenre = 'CO';
    
    DBMS_OUTPUT.PUT_LINE('Le nombre de comédies est : ' || v_nbrComidies);
END;
/