SET SERVEROUTPUT ON;

-- Déclaration des variables
DECLARE
    v_comm emp.comm%TYPE;
BEGIN
    -- Sélection de la commission de l'employé 'Alaoui'
    SELECT comm
    INTO v_comm
    FROM emp
    WHERE nom = 'ALAOU1I';

    -- Affichage du message correspondant à la commission
    IF v_comm > 0 THEN
        DBMS_OUTPUT.PUT_LINE('L''employé a une commission');
    ELSIF v_comm = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Commission égale à zéro');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Pas de commission');
    END IF;
        
END;
/


