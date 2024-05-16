SET SERVEROUTPUT ON;

-- 1. Afficher le No d’employé, le nom, fonction de l’employé ‘Alaoui’. Utiliser un curseur.
DECLARE
    v_num emp.num%TYPE;
    v_nom emp.nom%TYPE;
    v_fonction emp.fonction%TYPE;

    CURSOR emp_cursor IS
        SELECT num, nom, fonction
        FROM emp
        WHERE nom = 'ALAOUI';

BEGIN
    OPEN emp_cursor;
    FETCH emp_cursor INTO v_num, v_nom, v_fonction;
    CLOSE emp_cursor;

    DBMS_OUTPUT.PUT_LINE('No employé: ' || v_num || ', Nom: ' || v_nom || ', Fonction: ' || v_fonction);
END;
/

-- 2. Afficher le nom, le salaire et le nom du département de l’employé ‘Alaoui’.
DECLARE
    v_nom emp.nom%TYPE;
    v_sal emp.salaire%TYPE;
    v_dname dept.nom%TYPE;

    CURSOR emp_dept_cursor IS
        SELECT e.nom, e.salaire, d.nom
        FROM emp e
        JOIN dept d ON e.n_dept = d.n_dept
        WHERE e.nom = 'ALAOUI';

BEGIN
    OPEN emp_dept_cursor;
    FETCH emp_dept_cursor INTO v_nom, v_sal, v_dname;
    CLOSE emp_dept_cursor;

    DBMS_OUTPUT.PUT_LINE('Nom: ' || v_nom || ', Salaire: ' || v_sal || ', Département: ' || v_dname);
END;
/

-- 3. Afficher le nom, le salaire des cinq premiers employés de la table EMP.
DECLARE
    v_nom emp.nom%TYPE;
    v_sal emp.salaire%TYPE;
    v_counter NUMBER := 0;

    CURSOR first_five_emp_cursor IS
        SELECT *
        FROM (SELECT nom, salaire FROM emp)
        WHERE ROWNUM <= 5;

BEGIN
    OPEN first_five_emp_cursor;
    LOOP
        FETCH first_five_emp_cursor INTO v_nom, v_sal;
        EXIT WHEN first_five_emp_cursor%NOTFOUND;
        v_counter := v_counter + 1;
        DBMS_OUTPUT.PUT_LINE('Employé ' || v_counter || ': Nom: ' || v_nom || ', Salaire: ' || v_sal);
    END LOOP;
    CLOSE first_five_emp_cursor;
END;
/

-- 4. Afficher le nom et le salaire des 6 premiers employés de EMP. Utiliser %ROWCOUNT, %NOTFOUND et la boucle LOOP.
DECLARE
    v_nom emp.nom%TYPE;
    v_sal emp.salaire%TYPE;

    CURSOR first_six_emp_cursor IS
        SELECT nom, salaire
        FROM emp;

BEGIN
    OPEN first_six_emp_cursor;
    LOOP
        FETCH first_six_emp_cursor INTO v_nom, v_sal;
        EXIT WHEN first_six_emp_cursor%NOTFOUND OR first_six_emp_cursor%ROWCOUNT > 6;
        DBMS_OUTPUT.PUT_LINE('Employé ' || first_six_emp_cursor%ROWCOUNT || ': Nom: ' || v_nom || ', Salaire: ' || v_sal);
    END LOOP;
    CLOSE first_six_emp_cursor;
END;
/

-- 5. Afficher les 3 premières lignes de la table DEPT
DECLARE
    v_deptno dept.n_dept%TYPE;
    v_dname dept.nom%TYPE;
    v_loc dept.lieu%TYPE;
    v_counter NUMBER := 0;

    CURSOR first_three_dept_cursor IS
        SELECT * 
        FROM (SELECT n_dept, nom, lieu
                    FROM dept
                    )
        WHERE ROWNUM <= 3;

BEGIN
    OPEN first_three_dept_cursor;
    LOOP
        FETCH first_three_dept_cursor INTO v_deptno, v_dname, v_loc;
        EXIT WHEN first_three_dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Département ' || first_three_dept_cursor%ROWCOUNT || ': No: ' || v_deptno || ', Nom: ' || v_dname || ', Localisation: ' || v_loc);
    END LOOP;
    CLOSE first_three_dept_cursor;
END;
/

-- 6. Afficher le nom et le salaire de tous les employés de EMP.
DECLARE
    v_nom emp.nom%TYPE;
    v_sal emp.salaire%TYPE;

    CURSOR all_emp_cursor IS
        SELECT nom, salaire
        FROM emp;

BEGIN
    OPEN all_emp_cursor;
    LOOP
        FETCH all_emp_cursor INTO v_nom, v_sal;
        EXIT WHEN all_emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('>> Nom: ' || v_nom || ', Salaire: ' || v_sal);
    END LOOP;
    CLOSE all_emp_cursor;
END;
/

-- 7. Créer un curseur cur_emp qui ramène le no et le salaire de l’employé ‘Alaoui’.
--    Créer un enregistrement enr_emp de même type que cur_emp, lui affecter le résultat du
--    curseur et afficher le tout.
DECLARE
    CURSOR cur_emp IS
        SELECT num, salaire
        FROM emp
        WHERE nom = 'ALAOUI';

    TYPE emp_record IS RECORD (
        num emp.num%TYPE,
        salaire emp.salaire%TYPE
    );

    v_emp_rec emp_record;

BEGIN
    OPEN cur_emp;
    FETCH cur_emp INTO v_emp_rec.num, v_emp_rec.salaire;
    CLOSE cur_emp;

    DBMS_OUTPUT.PUT_LINE('No employé: ' || v_emp_rec.num || ', Salaire: ' || v_emp_rec.salaire);
END;
/
