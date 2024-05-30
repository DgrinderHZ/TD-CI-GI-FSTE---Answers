-- Insérer ceci pour avoir une sortie
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (6, 'Frank', 'Commercial', 45, 3600);

-- Exercice 8 : Affichage des noms des employés du département 'Commercial' âgés de plus de 40 ans
SET SERVEROUTPUT ON;

DECLARE
    v_nom EMPLOYE.NOM%TYPE;
BEGIN
    FOR rec IN ( -- un curseur implicite dans une boucle FOR
        SELECT NOM 
        FROM EMPLOYE
        WHERE DEPARTEMENT = 'Commercial' 
            AND AGE > 40
    ) 
    LOOP
        v_nom := rec.NOM;
        DBMS_OUTPUT.PUT_LINE('Employé : ' || v_nom);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur s''est produite : ' || SQLERRM);
END;
/
