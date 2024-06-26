-- Create TRACK_ABONNEMENTS table
CREATE TABLE TRACK_ABONNEMENTS (
    MAG_NOM VARCHAR2(100) PRIMARY KEY,
    NB_ABONN INTEGER
);

-- Insert into TRACK_ABONNEMENTS
INSERT INTO TRACK_ABONNEMENTS (MAG_NOM, NB_ABONN)
SELECT MAG_NOM, 0
FROM MAGAZINE;

COMMIT;

SET SERVEROUTPUT ON;
-- Exercice 15
CREATE OR REPLACE TRIGGER trgr_update_track_abonnements
AFTER INSERT ON ABONNEMENT
FOR EACH ROW
BEGIN
    -- Met à jour le nombre d'abonnements dans la table TRACK_ABONNEMENTS
    -- Après chaque ajout d'abonnement
    UPDATE TRACK_ABONNEMENTS
    SET NB_ABONN = NB_ABONN + 1
    WHERE MAG_NOM = (
        SELECT MAG_NOM
        FROM MAGAZINE
        WHERE MAG_ID = :NEW.MAG_ID
    );
END;
/


-- Insérer une nouvelle ligne dans la table ABONNEMENT
INSERT INTO ABONNEMENT (CL_ID, MAG_ID, START_DATE, END_DATE) VALUES (1, 1, SYSDATE, SYSDATE + 365);

-- Vérifier le contenu de la table TRACK_ABONNEMENTS
SELECT * FROM TRACK_ABONNEMENTS;

