SET SERVEROUTPUT ON;

DECLARE
    -- 0.25 pts
    v_numvol INT := 101;
    v_numav INT;
    v_numpil INT;
    v_exists INT;
    v_avion_exists INT;
    v_pilot_exists INT;

    e_vol_exists EXCEPTION;
    e_pilote_not_found EXCEPTION;
    e_avion_not_found EXCEPTION;
BEGIN
    -- Saisie des numéros d'avion et pilote par l'utilisateur  -- 0.25 pts
    v_numav := &NUMAV;
    v_numpil := &NUMPIL;

    BEGIN
        -- Vérification si le vol existe déjà -- 0.25 pts
        SELECT 1 INTO v_exists
        FROM VOL 
        WHERE NUMPIL = v_numpil 
              AND NUMAV = v_numav
              AND VILLE_DEP = 'Er-Rachidia' 
              AND VILLE_ARR = 'Marrakech' 
              AND H_DEP = TO_TIMESTAMP('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS') 
              AND H_ARR = TO_TIMESTAMP('2024-06-03 19:10:00', 'YYYY-MM-DD HH24:MI:SS');
        RAISE e_vol_exists;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            NULL; -- Le vol n'existe pas encore, on peut continuer
    END;

    -- Vérification de l'existence du pilote -- 0.25 pts
    BEGIN
        SELECT NUMPIL INTO v_pilot_exists FROM PILOTE WHERE NUMPIL = v_numpil;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_pilote_not_found;
    END;

    -- Vérification de l'existence de l'avion -- 0.25 pts
    BEGIN
        SELECT NUMAV INTO v_avion_exists FROM AVION WHERE NUMAV = v_numav;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE e_avion_not_found;
    END;

    -- Insertion du vol -- 0.25 pts
    INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES 
    (v_numvol, v_numpil, v_numav, 'Er-Rachidia', 'Marrakech', 
    -- 0.25 pts timestamp
    TO_TIMESTAMP('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-06-03 19:10:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    DBMS_OUTPUT.PUT_LINE('Vol inséré avec succès.');

EXCEPTION
    -- 0.25 pts
    WHEN e_vol_exists THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le vol existe déjà.');
    WHEN e_pilote_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le numéro de pilote n''existe pas.');
    WHEN e_avion_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le numéro d''avion n''existe pas.');
END;
/

------------------------------------ ou
SET SERVEROUTPUT ON;

DECLARE
    -- 0.25 pts
    v_numvol INT := 101;
    v_numav INT;
    v_numpil INT;
    v_exists INT;
    v_avion_exists INT;
    v_pilot_exists INT;
    
    e_vol_exists EXCEPTION;
    e_pilote_not_found EXCEPTION;
    e_avion_not_found EXCEPTION;
BEGIN
    -- Saisie des numéros d'avion et pilote par l'utilisateur  -- 0.25 pts
    v_numav := &NUMAV;
    v_numpil := &NUMPIL;

    BEGIN
        -- Vérification si le vol existe déjà -- 0.25 pts
        SELECT 1 INTO v_exists
        FROM VOL 
        WHERE NUMPIL = v_numpil 
              AND NUMAV = v_numav
              AND VILLE_DEP = 'Er-Rachidia' 
              AND VILLE_ARR = 'Marrakech' 
              AND H_DEP = TO_TIMESTAMP('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS') 
              AND H_ARR = TO_TIMESTAMP('2024-06-03 19:10:00', 'YYYY-MM-DD HH24:MI:SS');
        RAISE e_vol_exists;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            NULL; -- Le vol n'existe pas encore, on peut continuer
    END;

    -- Vérification de l'existence du pilote -- 0.25 pts
    SELECT count(NUMPIL) INTO v_pilot_exists FROM PILOTE WHERE NUMPIL = v_numpil;
    IF  v_pilot_exists=0 THEN
            RAISE e_pilote_not_found;
    END IF;

    -- Vérification de l'existence de l'avion -- 0.25 pts
    SELECT NUMAV INTO v_avion_exists FROM AVION WHERE NUMAV = v_numav;
    IF  v_avion_exists=0 THEN
            RAISE e_avion_not_found;
    END IF;

    -- Insertion du vol -- 0.25 pts
    INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES 
    (v_numvol, v_numpil, v_numav, 'Er-Rachidia', 'Marrakech', 
    -- 0.25 pts timestamp
    TO_TIMESTAMP('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
    TO_TIMESTAMP('2024-06-03 19:10:00', 'YYYY-MM-DD HH24:MI:SS'));
    
    DBMS_OUTPUT.PUT_LINE('Vol inséré avec succès.');

EXCEPTION
    -- 0.25 pts
    WHEN e_vol_exists THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le vol existe déjà.');
    WHEN e_pilote_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le numéro de pilote n''existe pas.');
    WHEN e_avion_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : le numéro d''avion n''existe pas.');
END;
/

