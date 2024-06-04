SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION pilotesErrLibres  -- 0.25 pts
RETURN INT  -- 0.25 pts
IS
    v_cpt INT;
BEGIN

    SELECT COUNT(*) -- 0.25 pts
    INTO v_cpt -- 0.25 pts
    FROM PILOTE p
    WHERE p.ADR = 'Er-Rachidia'  -- 0.25 pts
    AND p.NUMPIL NOT IN (  -- 0.25 pts
        SELECT NUMPIL -- 0.25 pts
        FROM VOL
    );
    
    RETURN v_cpt;  -- 0.25 pts
END;
/


-- TEST
DECLARE 
    v_cpt INT;
BEGIN
    v_cpt := pilotesErrLibres();
    DBMS_OUTPUT.PUT_LINE('le nombre de pilotes d’ErRachidia qui ne sont pas en service: ' || v_cpt);
END;
/