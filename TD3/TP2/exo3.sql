SET serveroutput ON;

-- Exercice 3 :

-- Variante 01: Déclaration comme variable PL/SQL :
DECLARE
    v_n NUMBER := 3; -- Modifier la valeur selon le besoin
    v_nbrActeur NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_nbrActeur
    FROM (
        SELECT numIndividu
        FROM ACTEUR
        GROUP BY numIndividu
        HAVING COUNT(*) >= v_n
    );
    
    DBMS_OUTPUT.PUT_LINE('Le nombre dacteurs ayant joué dans au moins ' || v_n || ' films est : ' || v_nbrActeur);
END;
/

-- Variante 02: Saisie par l’intermédiaire d’une variable utilisateur :
DECLARE
    v_n NUMBER;
    v_nbrActeur NUMBER;
BEGIN
    v_n := &n; -- Demander à l'utilisateur de saisir la valeur de v_n (variable de substitution)
    
    SELECT COUNT(*) INTO v_nbrActeur
    FROM (
        SELECT numIndividu
        FROM ACTEUR
        GROUP BY numIndividu
        HAVING COUNT(*) >= v_n
    );
    
    DBMS_OUTPUT.PUT_LINE('Le nombre dacteurs ayant joué dans au moins ' || v_n || ' films est : ' || v_nbrActeur);
END;
/

-- Variante 03: Déclaration comme une variable hôte dans SQL Developer :
VARIABLE vh_n NUMBER;
-- Affectation de valeur à la variables hôte
EXEC :vh_n := 3;
DECLARE
    v_n NUMBER;
    v_nbrActeur NUMBER;
BEGIN
    v_n := :n; -- Utilisation de la variable hôte (bind variable)
    
    SELECT COUNT(*) INTO v_nbrActeur
    FROM (
        SELECT numIndividu
        FROM ACTEUR
        GROUP BY numIndividu
        HAVING COUNT(*) >= n
    );
    
    DBMS_OUTPUT.PUT_LINE('Le nombre dacteurs ayant joué dans au moins ' || n || ' films est : ' || v_nbrActeur);
END;
/
