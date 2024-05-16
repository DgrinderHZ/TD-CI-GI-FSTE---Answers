SET SERVEROUTPUT ON;
-- Déclaration des variables
DECLARE
    v_deptno dept.n_dept%TYPE := 60;
    v_dname dept.nom%TYPE := 'RHU';
    v_loc dept.lieu%TYPE := 'Errachidia';
BEGIN
    -- Insertion des valeurs dans la table DEPT
    INSERT INTO dept (n_dept, nom, lieu)
    VALUES (v_deptno, v_dname, v_loc);

    -- Validation de la transaction
    COMMIT;
    
    -- Affichage d'un message de succès
    DBMS_OUTPUT.PUT_LINE('Les valeurs ont été insérées avec succès dans la table DEPT.');
END;
/
