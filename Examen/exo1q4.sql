SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_pilotes_vol IS -- 0.5 pts
        SELECT DISTINCT p.NUMPIL, p.NOMPIL 
        FROM PILOTE p 
        JOIN VOL v 
        ON p.NUMPIL = v.NUMPIL  
        WHERE p.ADR = v.VILLE_DEP; -- 0.5 pts
BEGIN
    FOR r_pilote IN c_pilotes_vol LOOP -- 0.5 pts
        -- 0.5 pts
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' ||
         r_pilote.NUMPIL || 
         ', NOMPIL: ' || r_pilote.NOMPIL);
    END LOOP;
END;
/


