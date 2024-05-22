SET serveroutput ON;

-- Exercice 5 :

-- a. Création de la table tableBonus
CREATE TABLE tableBonus (
    login VARCHAR2(50) PRIMARY KEY,
    bonus NUMBER(8, 2),
    nbrExLoues NUMBER(8),
    FOREIGN KEY (login) REFERENCES CLIENT(login)
);

-- b. Remplissage de la table tableBonus
DECLARE
    CURSOR cur_locations IS
        SELECT login, COUNT(*) AS nbr_locations
        FROM LOCATION
        WHERE EXTRACT(YEAR FROM dateLocation) = 2020
        GROUP BY login;
    
    v_login tableBonus.login%TYPE;
    v_bonus tableBonus.bonus%TYPE;
    v_nbrExLoues tableBonus.nbrExLoues%TYPE;
BEGIN
    FOR loc IN cur_locations LOOP
        v_bonus := 0;
        v_login := loc.login;
        v_nbrExLoues := loc.nbr_locations;
        
        INSERT INTO tableBonus 
        (login, bonus, nbrExLoues) 
        VALUES 
        (v_login, v_bonus, v_nbrExLoues);

    END LOOP;
    COMMIT;
END;
/


-- c. Variante 01: Mise à jour de la table tableBonus avec les bonus selon v_n1 et v_n2
DECLARE
    v_n1 NUMBER := 1; -- Modifier la valeur selon le besoin
    v_n2 NUMBER := 5; -- Modifier la valeur selon le besoin
BEGIN
    FOR rec IN (SELECT * FROM tableBonus) LOOP
        IF rec.nbrExLoues = 0 THEN
            rec.bonus := 0;
        ELSIF rec.nbrExLoues < v_n1 THEN
            rec.bonus := 0.1;
        ELSIF rec.nbrExLoues < v_n2 THEN
            rec.bonus := 0.2;
        ELSE
            rec.bonus := 0.4;
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- c. Variante 02: Mise à jour de la table tableBonus avec les bonus selon v_n1 et v_n2
DECLARE
    v_n1 NUMBER := 1; -- Modifier la valeur selon le besoin
    v_n2 NUMBER := 5; -- Modifier la valeur selon le besoin
BEGIN
    UPDATE tableBonus
    SET bonus = CASE 
                    WHEN nbrExLoues = 0 THEN 0
                    WHEN nbrExLoues < v_n1 THEN 0.1
                    WHEN nbrExLoues < v_n2 THEN 0.2
                    ELSE 0.4
                END;
    COMMIT;
END;
/

-- d. Affichage des clients avec leur nom, prénom et bonus
DECLARE
    CURSOR cur_clients IS
    
        SELECT c.nomClient, c.prenomClient, tb.bonus
        FROM CLIENT c
        JOIN tableBonus tb ON c.login = tb.login;
    
    v_nomClient CLIENT.nomClient%TYPE;
    v_prenomClient CLIENT.prenomClient%TYPE;
    v_bonus tableBonus.bonus%TYPE;
BEGIN
    FOR clt IN cur_clients LOOP
        v_nomClient := clt.nomClient;
        v_prenomClient := clt.prenomClient;
        v_bonus := clt.bonus;
        DBMS_OUTPUT.PUT_LINE('Nom : ' || v_nomClient || ', Prénom : ' || v_prenomClient || ', Bonus : ' || v_bonus);
    END LOOP;
END;
/
