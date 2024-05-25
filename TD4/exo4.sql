-- Exercice 4 : Gestion d'un tableau de carrés parfaits
DECLARE
    TYPE tableau_entiers IS VARRAY(50) OF NUMBER;
    v_tableau tableau_entiers;
BEGIN
    v_tableau := tableau_entiers();
    FOR i IN 1..20 LOOP
        v_tableau.EXTEND;
        v_tableau(i) := i * i;
    END LOOP;
    
    FOR i IN 1..v_tableau.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Carré parfait ' || i || ' : ' || v_tableau(i));
    END LOOP;

    -- Ajouter exception de depacement (range limit)
END;
/