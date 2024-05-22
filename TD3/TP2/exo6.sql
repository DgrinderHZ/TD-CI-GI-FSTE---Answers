SET serveroutput ON;

-- Exercice 6 :

SET SERVEROUTPUT ON;

DECLARE
    v_login VARCHAR2(50) := &login_de_client; -- Donner le client
    v_pourcentage NUMBER(8,2);
    v_nbr_location NUMBER(8,2);
BEGIN
    FOR ligne IN (SELECT g.libelleGenre, COUNT(*) AS nb_films_par_ctg
              FROM LOCATION l
              JOIN EXEMPLAIRE e ON l.numExemplaire = e.numExemplaire
              JOIN FILM f ON e.numFilm = f.numFilm
              JOIN GENREFILM gf ON f.numFilm = gf.numFilm
              JOIN GENRE g ON gf.numGenre = g.numGenre
              WHERE l.login = v_login
              GROUP BY g.libelleGenre)
    LOOP

        SELECT COUNT(*) 
        INTO v_nbr_location
        FROM LOCATION 
        WHERE login = v_login;
        
        IF v_nbr_location <> 0.0 THEN
            v_pourcentage := (ligne.nb_films_par_ctg / v_nbr_location)*100;
        ELSE
            v_pourcentage := 0;
        END IF;

        DBMS_OUTPUT.PUT('Type film : ' || ligne.libelleGenre);
        DBMS_OUTPUT.PUT_LINE(' Pourcentage : ' || TO_CHAR(v_pourcentage, 'FM999.00') || '%');

    END LOOP;
END;
/