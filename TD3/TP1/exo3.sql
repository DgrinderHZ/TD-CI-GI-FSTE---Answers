-- Création des variables sous SQL*Plus
VAR v_deptno NUMBER;
VAR v_dname VARCHAR2(30);
VAR v_loc VARCHAR2(30);

-- Affectation des valeurs aux variables SQL*Plus
EXEC :v_deptno := 70;
EXEC :v_dname := 'Finance';
EXEC :v_loc := 'Errachidia';

-- Création d'un bloc PL/SQL pour affecter ces variables à d'autres variables
BEGIN
    DECLARE
        v_deptno_plsql NUMBER;
        v_dname_plsql VARCHAR2(30);
        v_loc_plsql VARCHAR2(30);
    BEGIN
        -- Affectation des valeurs des variables SQL*Plus aux variables PL/SQL
        v_deptno_plsql := :v_deptno;
        v_dname_plsql := :v_dname;
        v_loc_plsql := :v_loc;
        
        -- Affichage des valeurs des variables PL/SQL
        DBMS_OUTPUT.PUT_LINE('v_deptno_plsql : ' || v_deptno_plsql);
        DBMS_OUTPUT.PUT_LINE('v_dname_plsql : ' || v_dname_plsql);
        DBMS_OUTPUT.PUT_LINE('v_loc_plsql : ' || v_loc_plsql);
    END;
END;
/
