SET SERVEROUTPUT ON;
-- Création de la table VOL
-- celui d'exercice 1

CREATE TABLE ESCALE (
    Numescale NUMBER PRIMARY KEY,
    Ville_Escale VARCHAR2(100),
    Durée_Escale NUMBER(5, 2) -- Durée en heures avec deux décimales
);

INSERT INTO VOL VALUES ('AF001', TO_TIMESTAMP('2024-05-30 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Paris', 'London');
INSERT INTO VOL VALUES ('AF002', TO_TIMESTAMP('2024-05-31 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-31 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'London', 'New York');
INSERT INTO VOL VALUES ('AF003', TO_TIMESTAMP('2024-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'New York', 'Tokyo');
INSERT INTO VOL VALUES ('AF004', TO_TIMESTAMP('2024-06-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tokyo', 'Sydney');
INSERT INTO VOL VALUES ('AF005', TO_TIMESTAMP('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Sydney', 'Paris');

INSERT INTO ESCALE VALUES (1, 'London', 1.5); -- 1.5 heures
INSERT INTO ESCALE VALUES (2, 'New York', 2.0); -- 2.0 heures
INSERT INTO ESCALE VALUES (3, 'Tokyo', 3.25); -- 3.25 heures
INSERT INTO ESCALE VALUES (4, 'Sydney', 4.0); -- 4.0 heures

-- Cas 01: supposons que les contraints suivantes sont vérifiés
--      - les escales ne sont pas enregistrés comme des vols eux-même
--      - pour le tour de monde de départ de Paris, les ville escales sont présentes
DECLARE
    v_depart VARCHAR2(100) := 'Paris';
    v_nombre_escales NUMBER := &v_nombre_escales;  -- Utiliser une variable de substitution pour le nombre d'escales
    v_total_escales NUMBER;
BEGIN
    -- Vérifier le nombre total d'escales disponibles
    SELECT COUNT(*) INTO v_total_escales FROM ESCALE;
    
    -- Lever une exception si le nombre d'escales demandé est supérieur au nombre disponible
    IF v_nombre_escales > v_total_escales THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le nombre d''escales demandé dépasse le nombre d''escales disponibles.');
    END IF;
    
    -- Afficher le parcours du tour du monde
    DBMS_OUTPUT.PUT(v_depart || ' -> ');

    FOR i IN 1..v_nombre_escales LOOP
        -- Récupérer la ville d'escale à partir du numéro d'escale
        SELECT Ville_Escale
        INTO v_depart
        FROM ESCALE
        WHERE Numescale = i;

        DBMS_OUTPUT.PUT(v_depart || ' -> ');
    END LOOP;

    -- Retour à la ville de départ
    DBMS_OUTPUT.PUT_LINE('Paris');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: Aucune escale trouvée pour le numéro d''escale spécifié.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/


-- Cas 02: supposons que les contraints doivent être vérifiés
--      - les escales sont enregistrés comme des vols eux-même 
--        le ville d'arrivé d'une est la ville de départ de la suivante
--      - pour le tour de monde de départ de paris, les villes escales sont présentes

-- Pour tester le script PL/SQL, nous devons insérer des données dans 
-- les tables ESCALE et VOL. Nous ajouterons des vols pour les escales 
-- 1 (Paris → London) et 2 (London → New York) et n'ajouterons pas 
-- de vols pour les escales 3 (New York → Tokyo) et 4 (Tokyo → Sydney), 
-- ce qui devrait déclencher une exception lorsque le script tente 
-- de vérifier ces vols.
-- Insérer des données dans la table VOL

INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (1, TO_TIMESTAMP('22-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 09:30', 'DD-MM-YYYY HH24:MI'), 'Paris', 'London');
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (2, TO_TIMESTAMP('22-05-2024 12:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 16:00', 'DD-MM-YYYY HH24:MI'), 'London', 'New York');
-- Ne pas ajouter de vols pour 'New York' -> 'Tokyo' et 'Tokyo' -> 'Sydney'
-- Ajouter un vol pour le retour à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (3, TO_TIMESTAMP('22-05-2024 20:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('23-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), 'New York', 'Paris');

DECLARE
    v_depart VARCHAR2(100) := 'Paris';
    v_nombre_escales NUMBER := &v_nombre_escales;  -- Utiliser une variable de substitution pour le nombre d'escales
    v_total_escales NUMBER;
    v_current_ville VARCHAR2(100) := v_depart;
    v_next_ville VARCHAR2(100);
    v_temp NUMBER;
BEGIN
    -- Verifier le nombre total d'escales disponibles
    SELECT COUNT(*) 
    INTO v_total_escales 
    FROM ESCALE;

    -- Lever une exception si le nombre d'escales demande est superieur au nombre disponible
    IF v_nombre_escales > v_total_escales THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le nombre d''escales demande depasse le nombre d''escales disponibles.');
    END IF;

    -- Afficher le parcours du tour du monde
    DBMS_OUTPUT.PUT(v_depart || ' -> ');

    FOR i IN 1..v_nombre_escales LOOP
        -- Recuperer la ville d'escale à partir du numero d'escale et verifier que les villes se suivent correctement
        SELECT Ville_Escale
        INTO v_next_ville
        FROM ESCALE
        WHERE Numescale = i;

        -- Verifier l'existence d'un vol de la ville actuelle vers la prochaine ville d'escale
        BEGIN
            SELECT 1
            INTO v_temp 
            FROM VOL 
            WHERE Ville_depart = v_current_ville 
                AND Ville_arrivee = v_next_ville;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20002, 'Aucun vol enregistre de ' || v_current_ville || ' vers ' || v_next_ville);
        END;

        DBMS_OUTPUT.PUT(v_next_ville || ' -> ');
        v_current_ville := v_next_ville;
    END LOOP;

    -- Verifier l'existence d'un vol de la dernière ville d'escale vers Paris
    BEGIN
        SELECT 1 INTO v_temp FROM VOL WHERE Ville_depart = v_current_ville AND Ville_arrivee = 'Paris';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'Aucun vol enregistre de ' || v_current_ville || ' vers Paris');
    END;

    -- Retour à la ville de depart
    DBMS_OUTPUT.PUT_LINE('Paris');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: Aucune escale trouvee pour le numero d''escale specifie.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: ' || SQLERRM);
END;
/


-- Ajouter un vol de London à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (4, TO_TIMESTAMP('22-05-2024 10:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 11:30', 'DD-MM-YYYY HH24:MI'), 'London', 'Paris');


-- N.B: vous pouver créer des fonction et procédures pour rendre le travail modulaire et bien organisé

