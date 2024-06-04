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











 -- 0.5 pts
CREATE OR REPLACE TYPE VARRAY_NUMPIL AS VARRAY(100) OF INT;
/

CREATE OR REPLACE FUNCTION tab_pilotes(fp_sal IN INT) -- 0.25 pts
RETURN VARRAY IS
    TYPE VARRAY_NUm is VARRAY(100) OF INT;
    v_pilote_tab VARRAY_NUM := VARRAY_NUM();  -- 0.25 pts
    v_index INT := 0;
    CURSOR c_pilotes(p_salaire INT) IS  -- 0.25 pts
         -- 0.5 pts
        SELECT NUMPIL 
        FROM PILOTE 
        WHERE SAL >= p_salaire; 
BEGIN
    FOR r_pilote IN c_pilotes(fp_sal) LOOP  -- 0.25 pts
        IF v_pilote_tab.COUNT < 100 THEN  -- 0.25 pts
            v_pilote_tab.EXTEND;  -- 0.25 pts
            v_pilote_tab(v_index + 1) := r_pilote.NUMPIL; -- 0.25 pts
            v_index := v_index + 1;   -- 0.25 pts
        ELSE
            EXIT;  -- 0.25 pts
        END IF;
    END LOOP;
    
    RETURN v_pilote_tab; -- 0.25 pts
END;
/


-- TEST
DECLARE
 TYPE VARRAY_NUm is VARRAY(100) OF INT;
    v_pilotes VARRAY_NUM;
BEGIN
    v_pilotes := tab_pilotes(50000);
    FOR i IN 1..v_pilotes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || v_pilotes(i));
    END LOOP;
END;
/
