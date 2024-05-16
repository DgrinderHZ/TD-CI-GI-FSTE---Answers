SET SERVEROUTPUT ON;

-- Déclaration de la variable pour le résultat du factoriel
DECLARE
    v_result NUMBER := 1;
BEGIN
    -- Calcul du factoriel de 5
     DBMS_OUTPUT.PUT('5! =');
    FOR i IN REVERSE 1..5 LOOP
        v_result := v_result * i;
        DBMS_OUTPUT.PUT(i);
        if i <> 1 then
            DBMS_OUTPUT.PUT('*');
            end if;
    END LOOP;

    -- Affichage du résultat
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT('    = ');
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/



