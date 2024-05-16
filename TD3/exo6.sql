SET SERVEROUTPUT ON;

-- Déclaration des variables
DECLARE
    n_nom emp.nom%TYPE;
    v_sal emp.salaire%TYPE;
BEGIN
    -- Sélection du nom et du salaire de l'employé 'Alaoui'
    SELECT nom, salaire
    INTO n_nom, v_sal
    FROM emp
    WHERE nom = 'ALAOUI';

    -- Affichage du nom et du salaire
    DBMS_OUTPUT.PUT_LINE('Nom: ' || n_nom || ', Salaire: ' || v_sal);

    -- Affichage d'un message supplémentaire basé sur le salaire
    IF v_sal < 1000 THEN
        DBMS_OUTPUT.PUT_LINE('Bas salaire');
    ELSIF v_sal >= 1000 THEN
        DBMS_OUTPUT.PUT_LINE('Haut salaire');
    END IF;
END;
/

