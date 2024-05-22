
SET SERVEROUTPUT ON;

-- Exercice 9. Création de la procédure pour afficher le nombre d'employés dépassant un âge limite par département
CREATE OR REPLACE PROCEDURE afficher_employes_age_limite (age_limite NUMBER) IS
    CURSOR c_departement (age_lim NUMBER) IS
        SELECT DEPARTEMENT, COUNT(*) AS nb_employes
        FROM EMPLOYE
        WHERE AGE > age_lim
        GROUP BY DEPARTEMENT;
        
BEGIN
    FOR rec IN c_departement(age_limite) LOOP
        DBMS_OUTPUT.PUT_LINE('Département: ' || rec.DEPARTEMENT || ' - Nombre demployés: ' || rec.nb_employes);
    END LOOP;
END;
/

-- Exécution de la procédure avec un exemple d'âge limite
BEGIN
    afficher_employes_age_limite(40); -- changer avec 30, 20, ...
END;
/

