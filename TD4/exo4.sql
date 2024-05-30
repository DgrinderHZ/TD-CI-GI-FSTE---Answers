SET SERVEROUTPUT ON;

-- Exercice 4 : Gestion d'un tableau de carrés parfaits
DECLARE
    TYPE tableau_entiers IS VARRAY(50) OF NUMBER;
    v_tableau tableau_entiers;
    v_taille NUMBER := 20; -- mettez 60 pour l'exception SUBSCRIPT_OUTSIDE_LIMIT
BEGIN
    v_tableau := tableau_entiers();
    FOR i IN 1..v_taille LOOP
        v_tableau.EXTEND; -- allocation dynamique
        v_tableau(i) := i * i;
    END LOOP;
    
    FOR i IN 1..v_tableau.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Carré parfait ' || i || ' : ' || v_tableau(i));
    END LOOP;

    -- Ajouter exception de depacement (range limit)
EXCEPTION
        WHEN SUBSCRIPT_OUTSIDE_LIMIT THEN
        DBMS_OUTPUT.PUT_LINE('Exception: Indice en dehors de la limite ');
END;
/