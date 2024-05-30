CREATE OR REPLACE TRIGGER trgr_verifier_insertion_ville
BEFORE INSERT ON METEO
FOR EACH ROW
DECLARE
    v_max_temp METEO.Temperature%TYPE;
    v_cpt_ville INTEGER; -- nombre de villes
BEGIN
    -- Vérifier si la Temperature de la nouvelle ville est la plus grande de toutes les villes
    SELECT MAX(Temperature) 
    INTO v_max_temp 
    FROM METEO;
    
    IF :NEW.Temperature > v_max_temp THEN
        DBMS_OUTPUT.PUT_LINE('Attention : La Temperature de la nouvelle ville est la plus grande de toutes les villes.');
    END IF;

    -- Vérifier si la ville existe déjà dans la table
    SELECT COUNT(*) 
    INTO v_cpt_ville 
    FROM METEO 
    WHERE NOM_VILLE = :NEW.NOM_VILLE;

    IF v_cpt_ville > 0 THEN
        -- Si la ville existe déjà, faire la mise à jour
        UPDATE METEO 
        SET Temperature = :NEW.Temperature, 
            Humidite = :NEW.Humidite 
        WHERE NOM_VILLE = :NEW.NOM_VILLE;
        DBMS_OUTPUT.PUT_LINE('La ville existe déjà dans la table. Mise à jour effectuée.');
        -- Ne pas insérer la nouvelle ville
        :NEW.NOM_VILLE := NULL; -- ça va générer une exception SQLCODE = -1400
    END IF;
END;
/

SET SERVEROUTPUT ON;
-- Maintenant on gère l'erreur du cas de mise à jours
-- où :NEW.NOM_VILLE := NULL; avec un procedure
CREATE OR REPLACE PROCEDURE insert_meteo_data(
    p_nom_ville METEO.NOM_VILLE%TYPE,
    p_temperature METEO.Temperature%TYPE,
    p_humidite METEO.Humidite%TYPE
)
IS
BEGIN
    INSERT INTO METEO (NOM_VILLE, Temperature, Humidite)
    VALUES (p_nom_ville, p_temperature, p_humidite);
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1400 THEN -- ORA-01400: cannot insert NULL into ("USER2"."METEO"."NOM_VILLE")
            DBMS_OUTPUT.PUT_LINE('Error: NOM_VILLE cannot be NULL.');
        END IF;
END;
/

BEGIN
    insert_meteo_data('New York', 70, 65);
END;
/

BEGIN
    insert_meteo_data('Paris', 22, 55);
END;
/


