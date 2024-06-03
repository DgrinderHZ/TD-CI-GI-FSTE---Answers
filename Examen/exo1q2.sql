SET SERVEROUTPUT ON;
DECLARE
    r_pilote pilote%ROWTYPE;
    CURSOR c_pilotes_en_service IS -- 0.5 pts
        SELECT DISTINCT p.* 
        FROM PILOTE p 
        JOIN VOL v ON p.NUMPIL = v.NUMPIL; -- 0.5 pts
BEGIN
    OPEN c_pilotes_en_service;
    LOOP
        FETCH c_pilotes_en_service INTO r_pilote; -- 0.5 pts
        EXIT WHEN c_pilotes_en_service%NOTFOUND;
        -- 0.5 pts
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || r_pilote.NUMPIL || ', NOMPIL: ' || r_pilote.NOMPIL || ', SAL: ' || r_pilote.SAL);
    END LOOP;
    CLOSE c_pilotes_en_service;
END;
/

-- Sans Jointure et sans FETCH
DECLARE
    r_pilote pilote%ROWTYPE;
    CURSOR c_pilotes_en_service IS -- 0.5 pts
        SELECT DISTINCT * 
        FROM PILOTE 
        WHERE NUMPIL IN ( -- 0.5 pts
            SELECT NUMPIL 
            FROM VOL
        );
BEGIN
       FOR r_pilote IN c_pilotes_en_service LOOP -- 0.5 pts
       -- 0.5 pts
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || r_pilote.NUMPIL || ', NOMPIL: ' || r_pilote.NOMPIL || ', SAL: ' || r_pilote.SAL);
    END LOOP;
END;
/