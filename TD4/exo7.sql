-- Création de la table EMPLOYE
CREATE TABLE EMPLOYE (
    ID NUMBER PRIMARY KEY,
    NOM VARCHAR2(100),
    DEPARTEMENT VARCHAR2(100),
    AGE NUMBER,
    SALAIRE NUMBER
);


-- Insertion de données dans la table EMPLOYE
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (1, 'Alice', 'Commercial', 30, 3000);
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (2, 'Bob', 'Commercial', 25, 2800);
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (3, 'Charlie', 'Technique', 28, 3200);
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (4, 'David', 'Technique', 35, 3400);
INSERT INTO EMPLOYE (ID, NOM, DEPARTEMENT, AGE, SALAIRE) VALUES (5, 'Eve', 'Commercial', 40, 3500);


-- Exercice 7 : Augmentation de salaire et affichage du nombre d'employés affectés
SET SERVEROUTPUT ON;

BEGIN
    -- Augmenter le salaire des employés du département 'Commercial'
    UPDATE EMPLOYE
    SET SALAIRE = SALAIRE + 200
    WHERE DEPARTEMENT = 'Commercial';
    
    -- Utiliser le dernier curseur implicite pour afficher le nombre d'employés affectés (3 employés pour notre jeu de données)
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employés ont eu une augmentation de salaire.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Une erreur sest produite : ' || SQLERRM);
END;
/
