SET SERVEROUTPUT ON;
-- Exercice 3 : Affichage de la somme des nombres entre 1000 et 10000
DECLARE
    v_somme NUMBER := 0;
    v_deb  NUMBER := 1000;
    v_fin  NUMBER := 10000;
BEGIN
    FOR i IN v_deb..v_fin LOOP
        v_somme := v_somme + i;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('La somme des nombres entre '|| v_deb ||' et '|| v_fin ||' est : ' || v_somme);
END;
/