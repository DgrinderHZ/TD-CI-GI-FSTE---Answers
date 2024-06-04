SET SERVEROUTPUT ON;
 
BEGIN
    FOR r_avion IN ( -- 0.5 pts
        SELECT numav, nomav, loc -- 0.25 pts
        FROM AVION 
        WHERE CAPACITE >= 50 -- 0.25 pts
    ) 
    LOOP 
        -- 0.25 pts
        DBMS_OUTPUT.PUT_LINE('NUMAV: ' || r_avion.NUMAV || ', NOMAV: ' || r_avion.NOMAV || ', LOC: ' || r_avion.LOC);
    END LOOP;
EXCEPTION -- 0.25 pts
        WHEN NO_DATA_FOUND THEN -- 0.25 pts
            DBMS_OUTPUT.PUT_LINE('Aucun avion trouvé avec une capacité >= 50.'); -- 0.25 pts
END;
/
