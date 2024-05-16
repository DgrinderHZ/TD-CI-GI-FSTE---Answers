SET SERVEROUTPUT ON;

DECLARE
    -- Déclaration du type d'enregistrement pour contenir les données d'une ligne DEPT
    TYPE dept_record_type IS RECORD (
        deptno   dept.n_dept%TYPE,
        dname    dept.nom%TYPE,
        loc      dept.lieu%TYPE
    );

    -- Déclaration d'une table PL/SQL pour stocker les données de la table DEPT
    TYPE dept_table_type IS TABLE OF dept_record_type INDEX BY BINARY_INTEGER;

    -- Déclaration de la variable pour stocker les données de la table DEPT
    v_dept_table dept_table_type;

    -- Curseur pour récupérer les données de la table DEPT
    CURSOR cur_dept IS
        SELECT n_dept, nom, lieu
        FROM dept;
BEGIN
    -- Ouverture du curseur
    OPEN cur_dept;
    
    -- Boucle pour récupérer et stocker les données de la table DEPT dans la table PL/SQL
    LOOP
        FETCH cur_dept BULK COLLECT INTO v_dept_table LIMIT 1000;
        EXIT WHEN cur_dept%NOTFOUND;
    END LOOP;
    
    -- Fermeture du curseur
    CLOSE cur_dept;
    
     -- Affichage des données récupérées
    FOR i IN 1..v_dept_table.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || v_dept_table(i).deptno || ', DNAME: ' || v_dept_table(i).dname || ', LOC: ' || v_dept_table(i).loc);
    END LOOP;
END;
/

