SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trgr_check_competition_code
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

-- Testing 

-- Création d'une procédure pour gérer l'insertion et gérer l'erreur ORA-01400
CREATE OR REPLACE PROCEDURE insert_competition (
    p_code_comp IN VARCHAR2,
    p_nom_competition IN VARCHAR2
) 
IS
BEGIN
    -- Tentative d'insertion de la nouvelle compétition
    INSERT INTO COMPETITION (CODE_COMP, NOM_COMPETITION) 
    VALUES (p_code_comp, p_nom_competition);

    DBMS_OUTPUT.put_line('Insertion réussie pour la compétition : ' || p_nom_competition);

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1400 THEN
            DBMS_OUTPUT.put_line('Erreur : Le code de la compétition ne peut pas être NULL.');
        ELSE
            DBMS_OUTPUT.put_line('Erreur : ' || SQLERRM);
        END IF;
END;
/

-- Test de la procédure avec des codes de compétition valides et invalides
BEGIN
    -- Insertion valide
    insert_competition('CMP003', 'Competition C');

    -- Insertion invalide
    insert_competition('CP003', 'Competition D');
END;
/



