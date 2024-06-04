SET SERVEROUTPUT ON;

 -- 0.5 pts
CREATE OR REPLACE TYPE VARRAY_NUMPIL AS VARRAY(100) OF INT;
/

CREATE OR REPLACE FUNCTION tab_pilotes(fp_sal IN INT) -- 0.25 pts
RETURN VARRAY_NUMPIL IS
    v_pilote_tab VARRAY_NUMPIL := VARRAY_NUMPIL();  -- 0.25 pts
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
    v_pilotes VARRAY_NUMPIL;
BEGIN
    v_pilotes := tab_pilotes(50000);
    FOR i IN 1..v_pilotes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('NUMPIL: ' || v_pilotes(i));
    END LOOP;
END;
/
