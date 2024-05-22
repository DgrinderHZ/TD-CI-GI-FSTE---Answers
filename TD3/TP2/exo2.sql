SET serveroutput ON;

-- Exécutons une requète simple
-- Executer ceci ==> un erreur! (Car il existe 3 films)
-- Si on supprime deux films et réexecuter
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;
BEGIN
    SELECT numFilm, titre, realisateur 
    INTO v_numFilm, v_titre, v_realisateur
    FROM FILM;
    
    DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm);
    DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Réalisateur : ' || v_realisateur);
END;
/

-- Exercice 2a PAS DE GESTION D'EXCEPTION:  
-- la requete qui cherche le film en question (avec 10 exemplaires)
-- ça doit retourner un film si les données de la base respecte la condition
-- Jouer avec votre base de données en ajoutant/supprimant des exemplaires ou
-- d'autre films avec 10 exemplaires pour voir les différents scénarios possibles
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;
BEGIN
    -- Pas de boucle 
    SELECT numFilm, titre, realisateur 
        INTO v_numFilm, v_titre, v_realisateur
    FROM FILM
    WHERE numFILM IN (
        SELECT numFilm
        FROM EXEMPLAIRE 
        GROUP BY numFilm 
        HAVING COUNT(*) = 10
    );

    DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm);
    DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Réalisateur : ' || v_realisateur);
END;
/

-- Exercice 2b, VARIANTE 01 avec Exception prédefini:
-- La gestion des execptions dépend de leurs type: 
--  1. Exception prédefini (Predefined Exceptions): NO_DATA_FOUND, TOO_MANY_ROWS, ...
--  2. Exception qu'on défini nous même 
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;
BEGIN
    SELECT numFilm, titre, realisateur 
    INTO v_numFilm, v_titre, v_realisateur
    FROM FILM
    WHERE numFilm IN (
        SELECT numFilm
        FROM EXEMPLAIRE 
        GROUP BY numFilm 
        HAVING COUNT(*) = 10
    );
    
    DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm);
    DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Réalisateur : ' || v_realisateur);

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Aucun film avec exactement 10 exemplaires trouvé.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Plusieurs films avec exactement 10 exemplaires trouvés.');
END;
/

-- Exercice 2b, VARIANTE 02 avec Exception utilisateur:
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;

    -- Déclaration des exceptions utilisateur
    e_aucun_film EXCEPTION;
    e_trop_de_films EXCEPTION;

    CURSOR c_film IS
        SELECT numFilm, titre, realisateur 
        FROM FILM
        WHERE numFilm IN (
            SELECT numFilm
            FROM EXEMPLAIRE 
            GROUP BY numFilm 
            HAVING COUNT(*) = 10
        );
BEGIN
    -- Récupération de premier film
    OPEN c_film;
    FETCH c_film INTO v_numFilm, v_titre, v_realisateur;

    -- Vérifiez si aucun film n'a été trouvé
    IF c_film%NOTFOUND THEN
        RAISE e_aucun_film;
    END IF;

    -- Vérifiez s'il y a plus d'un film
    FETCH c_film INTO v_numFilm, v_titre, v_realisateur;
    IF c_film%FOUND THEN
        RAISE e_trop_de_films;
    END IF;

    -- Si une seule ligne a été trouvée, affichez les détails du film
    DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm);
    DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
    DBMS_OUTPUT.PUT_LINE('Réalisateur : ' || v_realisateur);

    CLOSE c_film;

EXCEPTION
    -- Gestion des exceptions utilisateur
    WHEN e_aucun_film THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Aucun film ayant 10 exemplaires trouvé.');
    WHEN e_trop_de_films THEN
        DBMS_OUTPUT.PUT_LINE('Erreur : Plus dun film trouvé avec exactement 10 exemplaires.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erreur inattendue : ' || SQLERRM);
END;
/


-- Autre Variantes
-- Fusion des deux!!
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;

    -- Déclaration des exceptions utilisateur
    E_AUCUN_FILM EXCEPTION;
    E_TROP_DE_FILMS EXCEPTION;
BEGIN
    BEGIN
        SELECT numFilm, titre, realisateur 
        INTO v_numFilm, v_titre, v_realisateur
        FROM FILM
        WHERE numFilm IN (
            SELECT numFilm
            FROM EXEMPLAIRE 
            GROUP BY numFilm 
            HAVING COUNT(*) = 10
        );

        DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm);
        DBMS_OUTPUT.PUT_LINE('Titre : ' || v_titre);
        DBMS_OUTPUT.PUT_LINE('Réalisateur : ' || v_realisateur);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Lever l'exception utilisateur pour aucun film trouvé
            RAISE E_AUCUN_FILM;
        WHEN TOO_MANY_ROWS THEN
            -- Lever l'exception utilisateur pour trop de films trouvés
            RAISE E_TROP_DE_FILMS;
    END;

EXCEPTION
    -- Gestion des exceptions utilisateur
    WHEN E_Aucun_Film THEN
        DBMS_OUTPUT.PUT_LINE('Aucun film avec exactement 10 exemplaires trouvé.');
    WHEN E_TROP_DE_FILMS THEN
        DBMS_OUTPUT.PUT_LINE('Plusieurs films avec exactement 10 exemplaires trouvés.');
END;
/




