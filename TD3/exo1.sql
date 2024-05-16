SET SERVEROUTPUT ON;

-- Déclaration des variables
DECLARE
    v_deptno dept.n_dept%TYPE;
    v_dname dept.nom%TYPE;
    v_loc dept.lieu%TYPE;
BEGIN
    -- Affectation des valeurs du département numéro 20 aux variables
    SELECT n_dept, nom, lieu INTO v_deptno, v_dname, v_loc
    FROM dept
    WHERE n_dept = 20;

    -- Affichage des valeurs des variables
    DBMS_OUTPUT.PUT_LINE('Numéro du département : ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('Nom du département : ' || v_dname);
    DBMS_OUTPUT.PUT_LINE('Localisation du département : ' || v_loc);
END;
/
