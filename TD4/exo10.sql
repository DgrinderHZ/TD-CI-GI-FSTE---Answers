-- Création de la table METEO
CREATE TABLE METEO (
    NOM_VILLE VARCHAR2(50) PRIMARY KEY,
    Temperature NUMBER,
    Humidite NUMBER
);

-- Insertion de données dans la table METEO
INSERT INTO METEO (NOM_VILLE, Temperature, Humidite) VALUES ('Paris', 20, 65);
INSERT INTO METEO (NOM_VILLE, Temperature, Humidite) VALUES ('Lyon', 22, 70);
INSERT INTO METEO (NOM_VILLE, Temperature, Humidite) VALUES ('Marseille', 25, 60);
INSERT INTO METEO (NOM_VILLE, Temperature, Humidite) VALUES ('Bordeaux', 19, 75);
COMMIT;

-- Execice 10, Création de la fonction pour obtenir la Temperature et l'Humidite d'une ville
-- IN: nom de la ville
-- OUT: Une chaîne retournée par RETURN
-- avec EXCEPTION PREDIFINI ET DEFINI PAR UTILISATEUR
CREATE OR REPLACE FUNCTION obtenir_meteo_ville (p_nom_ville IN METEO.NOM_VILLE%TYPE)
    RETURN VARCHAR2
IS
    v_Temperature METEO.Temperature%TYPE;
    v_Humidite METEO.Humidite%TYPE;
    v_resultat VARCHAR2(200);
    
    E_VILLE_INCONNUE EXCEPTION;
BEGIN
    BEGIN
        -- Sélection des données de la ville
        SELECT Temperature, Humidite
        INTO v_Temperature, v_Humidite
        FROM METEO
        WHERE NOM_VILLE = p_nom_ville;
    
        -- Construction de la chaîne de résultat
        v_resultat := 'Temperature: ' || v_Temperature || ', Humidite: ' || v_Humidite;
        RETURN v_resultat;
    EXCEPTION
        -- Gestion des exceptions pour ville inconnue
        WHEN NO_DATA_FOUND THEN
            RAISE E_VILLE_INCONNUE;
    END;
EXCEPTION
    WHEN E_VILLE_INCONNUE THEN
        RETURN 'Erreur: La ville ' || p_nom_ville || ' n''existe pas.';
END obtenir_meteo_ville;
/

-- Appel de la fonction pour tester
DECLARE
    v_resultat VARCHAR2(200);
BEGIN
    -- Test avec une ville existante
    v_resultat := obtenir_meteo_ville('Paris');
    DBMS_OUTPUT.PUT_LINE(v_resultat);

    -- Test avec une ville inexistante
    v_resultat := obtenir_meteo_ville('Nice');
    DBMS_OUTPUT.PUT_LINE(v_resultat);
END;
/


-----------------------------------------------------------------------------
-- Execice 10 - VARIANTE 01, Création de la fonction pour obtenir la Temperature et l'Humidite d'une ville
-- Création du type d'objet MeteoType
-- IN: nom de la ville
-- OUT: Une objet MeteoType par RETURN
CREATE OR REPLACE TYPE MeteoType AS OBJECT (
    Temperature NUMBER,
    Humidite NUMBER
);
/

-- Création de la fonction pour obtenir la Temperature et l'Humidite d'une ville
CREATE OR REPLACE FUNCTION obtenir_meteo_ville (p_nom_ville IN VARCHAR2)
    RETURN MeteoType
IS
    v_meteo MeteoType := MeteoType(NULL, NULL);
BEGIN
    -- Sélection des données de la ville
    SELECT Temperature, Humidite
    INTO v_meteo.Temperature, v_meteo.Humidite
    FROM METEO
    WHERE NOM_VILLE = p_nom_ville;

    -- Retourner l'objet MeteoType
    RETURN v_meteo;

EXCEPTION
    -- Gestion des exceptions pour ville inconnue
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERREUR: La ville ' || p_nom_ville || ' n''existe pas.');
        RETURN NULL;

END obtenir_meteo_ville;
/

-- Appel de la fonction pour tester
DECLARE
    v_meteo  MeteoType := NULL;
BEGIN
    -- Test avec une ville existante
    v_meteo := obtenir_meteo_ville('Paris');
    IF v_meteo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Temperature: ' || v_meteo.Temperature || ', Humidite: ' || v_meteo.Humidite);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Erreur: La ville Paris n''existe pa s.');
    END IF;

    -- Test avec une ville inexistante
    v_meteo := obtenir_meteo_ville('Nice');
    IF v_meteo IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: La ville Nice n''existe pas.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Temperature: ' || v_meteo.Temperature || ', Humidite: ' || v_meteo.Humidite);
    END IF;
END;
/


-------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Exercice 10 - VARIANTE 02, Création de la fonction pour obtenir la Temperature et l'Humidite d'une ville
-- Création du type d'objet MeteoType
-- IN: nom de la ville
-- OUT: Une objet MeteoType par OUT
-- Création de la procédure pour obtenir la Temperature et l'Humidite d'une ville
CREATE OR REPLACE PROCEDURE obtenir_meteo_ville_in_out (
    p_nom_ville IN VARCHAR2,
    p_meteo OUT MeteoType
)
IS
BEGIN
    -- Initialisation de l'objet MeteoType
    p_meteo := MeteoType(NULL, NULL);
    
    -- Sélection des données de la ville
    SELECT Temperature, Humidite
    INTO p_meteo.Temperature, p_meteo.Humidite
    FROM METEO
    WHERE NOM_VILLE = p_nom_ville;
EXCEPTION
    -- Gestion des exceptions pour ville inconnue
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERREUR: La ville ' || p_nom_ville || ' n''existe pas.');
        p_meteo := NULL;

END obtenir_meteo_ville_in_out;
/

-- Appel de la procédure pour tester
DECLARE
    v_meteo  MeteoType;
BEGIN
    -- Test avec une ville existante
    obtenir_meteo_ville_in_out('Paris', v_meteo);
    IF v_meteo IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Temperature: ' || v_meteo.Temperature || ', Humidite: ' || v_meteo.Humidite);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Erreur: La ville Paris n''existe pas.');
    END IF;

    -- Test avec une ville inexistante
    obtenir_meteo_ville_in_out('Nice', v_meteo);
    IF v_meteo IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Erreur: La ville Nice n''existe pas.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Temperature: ' || v_meteo.Temperature || ', Humidite: ' || v_meteo.Humidite);
    END IF;
END;
/
