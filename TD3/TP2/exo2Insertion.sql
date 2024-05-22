-- Insertion d'un nouveau film
INSERT INTO FILM (numFilm, titre, realisateur) VALUES (2, 'Nouveau Film', 1);

-- Insertion de 10 exemplaires pour ce film
DECLARE
    v_numFilm NUMBER := 2; -- Le numéro du nouveau film
    v_numExemplaire NUMBER := 101; -- Point de départ pour les numéros d'exemplaire
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO EXEMPLAIRE (numExemplaire, numFilm) VALUES (v_numExemplaire, v_numFilm);
        v_numExemplaire := v_numExemplaire + 1;
    END LOOP;
END;
/