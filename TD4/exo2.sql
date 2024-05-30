-- Création de la table RES
CREATE TABLE RES (
    No NUMBER PRIMARY KEY
);

SET SERVEROUTPUT ON;

-- Exercice 2 : Insertion des chiffres de 1 à 100 dans la table RES
DECLARE 
    v_deb  NUMBER := 1;
    v_fin  NUMBER := 100;
    v_nombre NUMBER ;
BEGIN
    FOR i IN v_deb..v_fin LOOP
        v_nombre := i;
        INSERT INTO RES(NO) VALUES (v_nombre);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Les nombres de 1 à 100 ont été insérés avec succès.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le no '|| v_nombre ||' est déjà présent dans la table.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inattendue : ' || SQLERRM);
END;
/