SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER trgr_update_track_vols -- 0.25 pts
AFTER INSERT ON VOL  -- 0.25 pts
FOR EACH ROW -- 0.25 pts (pour utilise NEW and OLD)
BEGIN
    UPDATE TRACK_VOLS -- 0.25 pts
    SET NB_VOLS = NB_VOLS + 1   -- 0.5 pts
    WHERE NUMPIL = :NEW.NUMPIL;  -- 0.5 pts
END;
/

---- ou 
CREATE OR REPLACE TRIGGER trgr_update_track_vols -- 0.25 pts
AFTER INSERT ON VOL  -- 0.25 pts
FOR EACH ROW -- 0.25 pts (pour utilise NEW and OLD)
DECLARE
    v_n INT;
BEGIN
    SELECT NB_VOLS INTO v_n FROM TRACK_VOLS  WHERE numpil = :NEW.numpil;
    v_n := v_n + 1;
    
    UPDATE TRACK_VOLS -- 0.25 pts
    SET NB_VOLS = v_n  -- 0.5 pts
    WHERE NUMPIL = :NEW.NUMPIL;  -- 0.5 pts
END;
/


-- TEST
DECLARE
    v_nb_vols INT;
BEGIN
    SELECT NB_VOLS INTO v_nb_vols FROM TRACK_VOLS WHERE NUMPIL = 1;
    DBMS_OUTPUT.PUT_LINE('Nombre de vols avant l''insertion: ' || v_nb_vols); 
END;
/

INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES 
(4, 1, 1, 'Er-Rachidia', 'Marrakech', TO_TIMESTAMP('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-04 19:10:00', 'YYYY-MM-DD HH24:MI:SS'));
/

DECLARE
    v_nb_vols INT;
BEGIN
    SELECT NB_VOLS INTO v_nb_vols FROM TRACK_VOLS WHERE NUMPIL = 1;
    DBMS_OUTPUT.PUT_LINE('Nombre de vols avant l''insertion: ' || v_nb_vols);
END;
/