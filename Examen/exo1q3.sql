SET SERVEROUTPUT ON;
 
BEGIN
    FOR r_avion IN ( -- 0.5 pts
        SELECT numav, nomav, loc -- 0.25 pts
        FROM AVION 
        WHERE CAPACITE >= 50 -- 0.25 pts
    ) 
    LOOP 
        -- 0.25 pts
        DBMS_OUTPUT.PUT_LINE('NUMAV: ' || r_avion.NUMAV 
        || ', NOMAV: ' || r_avion.NOMAV 
        || ', LOC: ' || r_avion.LOC);
    END LOOP;
EXCEPTION -- 0.25 pts
        WHEN NO_DATA_FOUND THEN -- 0.25 pts
            DBMS_OUTPUT.PUT_LINE('Aucun avion trouvé avec une capacité >= 50.'); -- 0.25 pts
END;
/

---

SET SERVEROUTPUT ON;
DECLARE 
    v_n avion.NUMAV%TYPE;
    v_nom  avion.NOMAV%TYPE;
    v_l avion.LOC%TYPE;
    CURSOR c IS -- 0.5 pts
        SELECT numav, nomav, loc -- 0.25 pts
        FROM AVION 
        WHERE CAPACITE >= 50;-- 0.25 pts
    ex EXCEPTION;
BEGIN
    OPEN c;
    LOOP 
        FETCH c INTO v_n, v_nom, v_l;
        EXIT WHEN c%NOTFOUND;
        -- 0.25 pts
        DBMS_OUTPUT.PUT_LINE('NUMAV: ' ||v_n|| ', NOMAV: ' ||v_nom || ', LOC: ' || v_l);
    END LOOP;
    IF c%ROWCOUNT = 0 THEN
        RAISE ex;
    END IF;
    CLOSE c;
EXCEPTION -- 0.25 pts
        WHEN ex THEN -- 0.25 pts
            DBMS_OUTPUT.PUT_LINE('Aucun avion trouvé avec une capacité >= 50.'); -- 0.25 pts
END;
/

----------------------------- ou
SET SERVEROUTPUT ON;
DECLARE 
    v_n avion.NUMAV%TYPE;
    v_nom  avion.NOMAV%TYPE;
    v_l avion.LOC%TYPE;
    CURSOR c IS -- 0.5 pts
        SELECT numav, nomav, loc -- 0.25 pts
        FROM AVION 
        WHERE CAPACITE >= 50;-- 0.25 pts
    ex EXCEPTION;
BEGIN
    OPEN c;
    
    FETCH c INTO v_n, v_nom, v_l;
    WHILE c%FOUND LOOP 
        -- 0.25 pts
        DBMS_OUTPUT.PUT_LINE('NUMAV: ' ||v_n|| ', NOMAV: ' ||v_nom || ', LOC: ' || v_l);
        FETCH c INTO v_n, v_nom, v_l;
    END LOOP;
    CLOSE c;
EXCEPTION -- 0.25 pts
        WHEN NO_DATA_FOUND THEN -- 0.25 pts
            DBMS_OUTPUT.PUT_LINE('Aucun avion trouvé avec une capacité >= 50.'); -- 0.25 pts
END;
/