
-- Insertions des exercices précédents
INSERT INTO VOL VALUES ('AF001', TO_TIMESTAMP('2024-05-30 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-30 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Paris', 'London');
INSERT INTO VOL VALUES ('AF002', TO_TIMESTAMP('2024-05-31 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-05-31 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'London', 'New York');
INSERT INTO VOL VALUES ('AF003', TO_TIMESTAMP('2024-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'New York', 'Tokyo');
INSERT INTO VOL VALUES ('AF004', TO_TIMESTAMP('2024-06-02 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Tokyo', 'Sydney');
INSERT INTO VOL VALUES ('AF005', TO_TIMESTAMP('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-03 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Sydney', 'Paris');

INSERT INTO ESCALE VALUES (1, 'London', 1.5); -- 1.5 heures
INSERT INTO ESCALE VALUES (2, 'New York', 2.0); -- 2.0 heures
INSERT INTO ESCALE VALUES (3, 'Tokyo', 3.25); -- 3.25 heures
INSERT INTO ESCALE VALUES (4, 'Sydney', 4.0); -- 4.0 heures

INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (1, TO_TIMESTAMP('22-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 09:30', 'DD-MM-YYYY HH24:MI'), 'Paris', 'London');
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (2, TO_TIMESTAMP('22-05-2024 12:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 16:00', 'DD-MM-YYYY HH24:MI'), 'London', 'New York');
-- Ne pas ajouter de vols pour 'New York' -> 'Tokyo' et 'Tokyo' -> 'Sydney'
-- Ajouter un vol pour le retour à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (3, TO_TIMESTAMP('22-05-2024 20:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('23-05-2024 08:00', 'DD-MM-YYYY HH24:MI'), 'New York', 'Paris');
-- Ajouter un vol de London à Paris
INSERT INTO VOL (Numvol, Heure_depart, Heure_arrivee, Ville_depart, Ville_arrivee) VALUES (4, TO_TIMESTAMP('22-05-2024 10:00', 'DD-MM-YYYY HH24:MI'), TO_TIMESTAMP('22-05-2024 11:30', 'DD-MM-YYYY HH24:MI'), 'London', 'Paris');


---- Exercice 18
CREATE OR REPLACE PROCEDURE trouve_escales(
    v_depart IN VOL.Ville_depart%TYPE,
    v_current IN VOL.Ville_arrivee%TYPE,
    escales IN NUMBER,
    max_escales IN NUMBER
) 
IS
    v_numvol VOL.Numvol%TYPE;
    v_ville_arrivee VOL.Ville_arrivee%TYPE;
    
    CURSOR vols_cur IS
        SELECT Numvol, Ville_arrivee FROM VOL WHERE Ville_depart = v_current;
BEGIN
    IF escales <= max_escales THEN
        FOR v IN vols_cur LOOP
            DBMS_OUTPUT.PUT_LINE('Vol ' || v.Numvol || ': ' || v_current || ' -> ' || v.Ville_arrivee);
            IF v.Ville_arrivee = v_depart THEN
                DBMS_OUTPUT.PUT_LINE('Retour à ' || v_depart);
            ELSE
                trouve_escales(v_depart, v.Ville_arrivee, escales + 1, max_escales);
            END IF;
        END LOOP;
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE tour_du_monde(
    v_depart IN VOL.Ville_depart%TYPE,
    min_escales IN NUMBER,
    max_escales IN NUMBER
) AS
    nbr_escale Number;
BEGIN
    FOR i IN min_escales..max_escales LOOP
         nbr_escale :=  i-1;
        DBMS_OUTPUT.PUT_LINE('Tour avec ' ||  nbr_escale || ' escale(s):');
        trouve_escales(v_depart, v_depart, 1, i);
    END LOOP;
END;
/

SET SERVEROUTPUT ON;
EXEC tour_du_monde('Paris', 1, 3);

