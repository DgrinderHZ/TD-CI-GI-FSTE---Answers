SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE profilePilote(p_numpil IN INT) IS -- 0.25 pts
    -- 0.5 pts
    v_pilote PILOTE%ROWTYPE;
BEGIN
    
    SELECT *   
    INTO v_pilote -- 0.25
    FROM PILOTE 
    WHERE NUMPIL = p_numpil; -- 0.25 pts
    
    -- 0.25 pts
    DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || 
    v_pilote.NUMPIL || ', NOMPIL: ' || 
    v_pilote.NOMPIL || ', ADR: ' || 
    v_pilote.ADR || ', SAL: ' || v_pilote.SAL);

EXCEPTION  -- 0.5 pts
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Erreur : le pilote n''existe pas.');
END;
/

-- TEST
BEGIN
profilePilote(4);
END;
/