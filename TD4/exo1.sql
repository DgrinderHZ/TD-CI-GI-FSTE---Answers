-- Création de la table VOL
CREATE TABLE VOL (
    Numvol VARCHAR2(10) PRIMARY KEY,
    Heure_départ DATE,
    Heure_arrivée DATE,
    Ville_départ VARCHAR2(50),
    Ville_arrivée VARCHAR2(50)
);

SET SERVEROUTPUT ON;
-- Exercice 1 : Insertion du vol AF110, prendre l'hypothèse en considération (pas de duplication)
DECLARE
    v_numvol VARCHAR2(10) := 'AF110';
    v_heure_depart DATE := TO_DATE('22-05-2024 21:40', 'DD-MM-YYYY HH24:MI'); -- Date et heure de départ
    v_heure_arrivee DATE := TO_DATE('22-05-2024 23:10', 'DD-MM-YYYY HH24:MI'); -- Date et heure d'arrivée
    v_ville_depart VARCHAR2(50) := 'Paris';
    v_ville_arrivee VARCHAR2(50) := 'Dublin';
BEGIN
    INSERT INTO VOL (Numvol, Heure_départ, Heure_arrivée, Ville_départ, Ville_arrivée)
    VALUES (v_numvol, v_heure_depart, v_heure_arrivee, v_ville_depart, v_ville_arrivee);
    DBMS_OUTPUT.PUT_LINE('Vol inséré avec succès.');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Le vol est déjà présent dans la table.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inattendue : ' || SQLERRM);
END;
/
