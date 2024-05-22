SET serveroutput ON;

-- Exercice 4 : Curseurs
DECLARE
    v_numFilm FILM.numFilm%TYPE;
    v_titre FILM.titre%TYPE;
    v_realisateur FILM.realisateur%TYPE;
    -- Donner la valeur selon le besoin
    v_numIndividu ACTEUR.numIndividu%TYPE := &numIndividu; 
    
    CURSOR cur_films (v_numIndividu NUMBER) IS
        SELECT f.numFilm, f.titre, f.realisateur
        FROM FILM f
        JOIN ACTEUR a ON f.numFilm = a.numFilm
        WHERE a.numIndividu = v_numIndividu;
BEGIN
    OPEN cur_films(v_numIndividu);
    LOOP
        FETCH cur_films INTO v_numFilm, v_titre, v_realisateur;
        EXIT WHEN cur_films%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Numéro du film : ' || v_numfilm || 'Titre: ' || v_titre || 'Num. Réalisateur: ' || v_realisateur);
    END LOOP;
    CLOSE cur_films;
END;
/
