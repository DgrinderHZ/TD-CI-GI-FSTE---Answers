SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trg_check_competition_code
BEFORE INSERT ON COMPETITION
FOR EACH ROW
DECLARE 
    NE_COMMENCE_PAS_PAR_CMP EXCEPTION;
BEGIN
    IF :NEW.CODE_COMP NOT LIKE 'CMP%' THEN
        RAISE NE_COMMENCE_PAS_PAR_CMP;
    END IF;

EXCEPTION
    WHEN NE_COMMENCE_PAS_PAR_CMP THEN
        DBMS_OUTPUT.put_line('Le code de la compétition doit commencer par "CMP".');
        :NEW.CODE_COMP := NULL;
END;
/

-- Vous pouvez gérer l'erreur ORA-01400 cannot insert NULL 
-- Avec le même principe de l'exercice 11
INSERT INTO COMPETITION (CODE_COMP, NOM_COMPETITION) VALUES ('CMP003', 'Competition C'); -- pas d'erreur
INSERT INTO COMPETITION (CODE_COMP, NOM_COMPETITION) VALUES ('CP003', 'Competition D'); -- ops!

