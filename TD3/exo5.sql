SET SERVEROUTPUT ON;

-- Déclaration d'une variable de type RECORD pour stocker une ligne de la table DEPT
DECLARE
    v_dept dept%ROWTYPE;
BEGIN
    -- Sélection de la ligne de la table DEPT pour le département 30
    SELECT *
    INTO v_dept
    FROM dept
    WHERE n_dept = 30;

    -- Affichage du contenu de la variable v_dept
    DBMS_OUTPUT.PUT_LINE('Deptno: ' || v_dept.n_dept);
    DBMS_OUTPUT.PUT_LINE('Dname: ' || v_dept.nom);
    DBMS_OUTPUT.PUT_LINE('Loc: ' || v_dept.lieu);
END;
/
