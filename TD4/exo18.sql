
-- Insertions des exercices précédents
INSERT INTO VOL VALUES ('AF001', TO_TIMESTAMP('2024-05-30 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Paris', 'London');
INSERT INTO VOL VALUES ('AF002', TO_TIMESTAMP('2024-05-31 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-31 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'London', 'New York');
INSERT INTO VOL VALUES ('AF003', TO_TIMESTAMP('2024-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'New York', 'Tokyo');
INSERT INTO VOL VALUES ('AF004', TO_TIMESTAMP('2024-06-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tokyo', 'Sydney');
INSERT INTO VOL VALUES ('AF005', TO_TIMESTAMP('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Sydney', 'Paris');
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (1, TO_TIMESTAMP('22-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 09:30', 'DD-MM-YYYY HH24:MI'), 'Paris', 'London');
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (2, TO_TIMESTAMP('22-05-2024 12:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 16:00', 'DD-MM-YYYY HH24:MI'), 'London', 'New York');
-- Ne pas ajouter de vols pour 'New York' -> 'Tokyo' et 'Tokyo' -> 'Sydney'
-- Ajouter un vol pour le retour à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (3, TO_TIMESTAMP('22-05-2024 20:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('23-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), 'New York', 'Paris');
-- Ajouter un vol de London à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (4, TO_TIMESTAMP('22-05-2024 10:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 11:30', 'DD-MM-YYYY HH24:MI'), 'London', 'Paris');

CREATE TABLE ESCALE (
    id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    numvol VARCHAR2(10),
    ville_escale VARCHAR2(50),
    durée_escale NUMBER
);

---- Exercice 18
CREATE OR REPLACE FUNCTION trouve_escales(
    v_depart_et_dest_final  IN VOL.Ville_depart%TYPE, -- fixe
    v_courant IN VOL.Ville_arrivee%TYPE, -- change pour chaque appel
    itr_escales IN NUMBER, -- iterateur d'escale
    max_escales IN NUMBER -- nombre d'escale fixé par l'utilisateur
) RETURN NUMBER
IS
    v_numvol VOL.Numvol%TYPE;
    v_ville_arrivee VOL.Ville_arrivee%TYPE;
    v_nbr_vol NUMBER;
    
    -- Récupérer les vols ayant comme Ville_depart = v_courant
    CURSOR vols_cur IS
        SELECT Numvol, Ville_arrivee 
        FROM VOL 
        WHERE Ville_depart = v_courant;
BEGIN
    -- Cas de base (Base Case)
    -- Si (itr_escales = max_escales) alors
    -- Il faut chercher les vols de retour vers la ville de départ (destination finale)
    IF itr_escales = max_escales THEN
        -- Pour chaque dernière ville d'escale
        FOR vol_vers_dern_escale IN vols_cur LOOP
            -- vols_derniere_escale_vers_dest_finale
            FOR vol_final IN (
                SELECT Numvol, Ville_depart, Ville_arrivee 
                FROM VOL 
                WHERE Ville_depart = vol_vers_dern_escale.Ville_arrivee -- dernière escale
                    AND Ville_arrivee = v_depart_et_dest_final -- destination finale
            ) 
            LOOP
                -- Insertion d'escale
                -- TODO: stocker dans une collection
                -- pour éviter les vols non pertinente
                INSERT INTO ESCALE(numvol, ville_escale, durée_escale) 
                VALUES (vol_final.Numvol, vol_final.Ville_depart, 1.5); -- 1.5 heures
            END LOOP; -- FOR vol_final
        END LOOP; -- FOR vol_vers_dern_escale

    ELSIF itr_escales < max_escales THEN
        -- Pour chaque vol intermédiaire
        FOR vol_vers_escale_inter IN vols_cur LOOP
            -- Vérifier s'il existe des vols depuis la ville d'arrivée
            SELECT COUNT(*)
            INTO v_nbr_vol
            FROM VOL 
            WHERE Ville_depart = vol_vers_escale_inter.Ville_arrivee;

            IF v_nbr_vol >= 1 THEN
                -- TODO: stocker dans une collection
                -- pour éviter les vols non pertinente
                -- Insertion d'escale
                INSERT INTO ESCALE(numvol, ville_escale, durée_escale)
                VALUES(vol_vers_escale_inter.Numvol, vol_vers_escale_inter.Ville_arrivee, 1.5); -- 1.5 heures
                
                -- Trouver les vols suivants pour chaque escale
                trouve_escales(v_depart_et_dest_final, vol_vers_escale_inter.Ville_arrivee, itr_escales + 1, max_escales);
            END IF;
        END LOOP; -- FOR vol_vers_escale_inter
    END IF;

END;
/

CREATE OR REPLACE PROCEDURE tour_du_monde(
    v_depart IN VOL.Ville_depart%TYPE,
    min_escales IN NUMBER,
    max_escales IN NUMBER
) AS
BEGIN
    FOR i IN min_escales..max_escales LOOP
        DBMS_OUTPUT.PUT_LINE('Tour avec ' || i || ' escale(s):');
        
        -- Nettoyer la table ESCALE avant chaque nouvelle recherche
        DELETE FROM ESCALE;
        
        -- Appeler la procédure récursive pour trouver les escales
        trouve_escales(v_depart, v_depart, 1, i);
        
        -- Afficher les résultats des escales trouvées
        FOR r IN (SELECT * FROM ESCALE) LOOP
            DBMS_OUTPUT.PUT_LINE('ID: ' || r.id || ' Numéro de Vol: ' || r.numvol || ' Ville Escale: ' || r.ville_escale || ' Durée: ' || r.durée_escale || ' heures');
        END LOOP;
    END LOOP;
END;
/


SET SERVEROUTPUT ON;
EXEC tour_du_monde('Paris', 1, 4);
