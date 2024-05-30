-- Create CLIENT table
CREATE TABLE CLIENT2 (
    CL_ID NUMBER PRIMARY KEY,
    CL_NOM VARCHAR2(100),
    CL_ADDR VARCHAR2(200),
    CL_VILLE VARCHAR2(100),
    EMAILID VARCHAR2(100),
    CONTACT_NO VARCHAR2(15)
);

-- Create MAGAZINE table
CREATE TABLE MAGAZINE (
    MAG_ID NUMBER PRIMARY KEY,
    MAG_NOM VARCHAR2(100),
    PRIX_UNITE NUMBER,
    TYPE_ABONNEMENT VARCHAR2(100)
);

-- Create ABONNEMENT table
CREATE TABLE ABONNEMENT (
    CL_ID NUMBER,
    MAG_ID NUMBER,
    START_DATE DATE,
    END_DATE DATE,
    FOREIGN KEY (CL_ID) REFERENCES CLIENT2(CL_ID),
    FOREIGN KEY (MAG_ID) REFERENCES MAGAZINE(MAG_ID)
);

-- Insert sample data
INSERT INTO CLIENT2 (CL_ID, CL_NOM, CL_ADDR, CL_VILLE, EMAILID, CONTACT_NO) 
VALUES (1, 'Client 1', 'Address 1', 'Errachidia', 'client1@example.com', '0123456789');

INSERT INTO CLIENT2 (CL_ID, CL_NOM, CL_ADDR, CL_VILLE, EMAILID, CONTACT_NO) 
VALUES (2, 'Client 2', 'Address 2', 'Errachidia', 'client2@example.com', '0987654321');

INSERT INTO CLIENT2 (CL_ID, CL_NOM, CL_ADDR, CL_VILLE, EMAILID, CONTACT_NO) 
VALUES (3, 'Client 3', 'Address 3', 'OtherCity', 'client3@example.com', '0123456789');

INSERT INTO MAGAZINE (MAG_ID, MAG_NOM, PRIX_UNITE, TYPE_ABONNEMENT) 
VALUES (1, 'Vogue', 10, 'Monthly');

INSERT INTO MAGAZINE (MAG_ID, MAG_NOM, PRIX_UNITE, TYPE_ABONNEMENT) 
VALUES (2, 'OtherMag', 5, 'Weekly');

INSERT INTO ABONNEMENT (CL_ID, MAG_ID, START_DATE, END_DATE) 
VALUES (1, 1, DATE '2020-09-01', DATE '2021-09-01');

INSERT INTO ABONNEMENT (CL_ID, MAG_ID, START_DATE, END_DATE) 
VALUES (2, 1, DATE '2020-10-01', DATE '2021-10-01');

INSERT INTO ABONNEMENT (CL_ID, MAG_ID, START_DATE, END_DATE) 
VALUES (3, 1, DATE '2020-11-01', DATE '2021-11-01');

COMMIT;

SET SERVEROUTPUT ON;
-- La fonction PL/SQL qui retourne le nombre de clients d’Errachidia qui se sont abonnés au
-- magazine « Vogue » après août 2020. 
CREATE OR REPLACE FUNCTION compter_errachidia_abonnes_vogue
    RETURN NUMBER
IS
    v_cpt NUMBER;
    PAS_D_ABONNES_TROUVE EXCEPTION;
BEGIN
    --  le nombre de clients d’Errachidia qui se sont abonnés au
    --  magazine « Vogue » après août 2020
    SELECT COUNT(*)
    INTO v_cpt
    FROM CLIENT2 c
    JOIN ABONNEMENT a ON c.CL_ID = a.CL_ID
    JOIN MAGAZINE m ON a.MAG_ID = m.MAG_ID
    WHERE c.CL_VILLE = 'Errachidia'
      AND m.MAG_NOM = 'Vogue'
      AND a.START_DATE > DATE '2020-08-31';
    
    IF v_cpt = 0 THEN
        RAISE PAS_D_ABONNES_TROUVE;
    END IF;
    
    RETURN v_cpt;
    
EXCEPTION
    WHEN PAS_D_ABONNES_TROUVE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Aucun client d''Errachidia ne s''est abonné à Vogue après août 2020.');
END compter_errachidia_abonnes_vogue;
/

-- Test avec les deux scénarios possible
DECLARE
    v_result NUMBER;
BEGIN
    v_result := compter_errachidia_abonnes_vogue;
    DBMS_OUTPUT.PUT_LINE('Nombre des abonnés: ' || v_result);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
