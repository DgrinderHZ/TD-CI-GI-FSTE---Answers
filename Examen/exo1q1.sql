SET SERVEROUTPUT ON;
BEGIN
    FOR r_pilote IN ( -- 0.5 pts
        SELECT * 
        FROM PILOTE 
        WHERE ADR = 'Er-Rachidia'  -- 0.5 pts
        ORDER BY SAL -- 0.5 pts
    ) 
    LOOP
        -- 0.5 pts
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || r_pilote.NUMPIL ||
         ', NOMPIL: ' || r_pilote.NOMPIL || ', ADR: ' ||
          r_pilote.ADR || ', SAL: ' || r_pilote.SAL);
    END LOOP;
END;
/
