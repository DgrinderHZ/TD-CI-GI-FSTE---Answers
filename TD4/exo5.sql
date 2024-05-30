CREATE TABLE PILOTE (
    Matricule NUMBER PRIMARY KEY,
    Nom VARCHAR2(100),
    Ville VARCHAR2(100),
    Age NUMBER,
    Salaire NUMBER(10, 2)
);

INSERT INTO PILOTE (Matricule, Nom, Ville, Age, Salaire) VALUES (1, 'Dupont', 'Paris', 35, 50000);
INSERT INTO PILOTE (Matricule, Nom, Ville, Age, Salaire) VALUES (2, 'Durand', 'Lyon', 40, 55000);
INSERT INTO PILOTE (Matricule, Nom, Ville, Age, Salaire) VALUES (3, 'Martin', 'Marseille', 45, 60000);
INSERT INTO PILOTE (Matricule, Nom, Ville, Age, Salaire) VALUES (4, 'Lefevre', 'Toulouse', 32, 48000);

SET SERVEROUTPUT ON;

-- Exercice 5 : Calcul de la moyenne des salaires des pilotes âgés de 30 à 40 ans
DECLARE
    v_moyenne_salaires NUMBER;
BEGIN
    SELECT AVG(Salaire)
    INTO v_moyenne_salaires
    FROM PILOTE
    WHERE Age BETWEEN 30 AND 40;
    
    DBMS_OUTPUT.PUT_LINE('La moyenne des salaires des pilotes âgés de 30 à 40 ans est : ' || v_moyenne_salaires);
END;
/