DECLARE
    CURSOR c_films IS
        SELECT numFilm, COUNT(*) AS nbrExemplaires
        FROM EXEMPLAIRE
        GROUP BY numFilm;

    v_numFilm FILM.numFilm%TYPE;
    v_nbrExemplaires NUMBER;

    -- Déclaration de l'exception personnalisée
    FILM_AVEC_AUX_MOINS_DEUX_EXEMPLAIRES EXCEPTION;
BEGIN
    FOR film_rec IN c_films LOOP
        v_numFilm := film_rec.numFilm;
        v_nbrExemplaires := film_rec.nbrExemplaires;
        DBMS_OUTPUT.PUT_LINE('Numéro de film : ' || v_numFilm || ', Nombre d''exemplaires : ' || v_nbrExemplaires);

        -- Si un film a deux exemplaires, lever l'exception (= ou >=)
        IF v_nbrExemplaires >= 2 THEN
            RAISE FILM_AVEC_AUX_MOINS_DEUX_EXEMPLAIRES;
        END IF;
    END LOOP;

    -- Si l'exception n'a pas été levée, afficher un message de confirmation
    DBMS_OUTPUT.PUT_LINE('Aucun film n''a deux exemplaires.');
EXCEPTION
    -- Gérer l'exception personnalisée
    WHEN FILM_AVEC_AUX_MOINS_DEUX_EXEMPLAIRES THEN
        DBMS_OUTPUT.PUT_LINE('Au moins un film a deux exemplaires.');
END;
/
