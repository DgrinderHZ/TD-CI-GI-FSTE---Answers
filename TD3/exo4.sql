SET SERVEROUTPUT ON;

DECLARE
    v_deptno DEPT.N_DEPT%TYPE;
    v_dname DEPT.NOM%TYPE;
    v_loc DEPT.LIEU%TYPE;

    -- Declare a cursor for selecting data from DEPT
    CURSOR dept_cursor IS
        SELECT N_DEPT, NOM, LIEU
        FROM DEPT
        WHERE N_DEPT = 30;
BEGIN
    -- Open the cursor
    OPEN dept_cursor;

    -- Fetch data into variables
    FETCH dept_cursor INTO v_deptno, v_dname, v_loc;

    -- Display the values of the variables
    IF dept_cursor%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Department No: ' || v_deptno);
        DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_dname);
        DBMS_OUTPUT.PUT_LINE('Department Location: ' || v_loc);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No data found for department number 30');
    END IF;

    -- Close the cursor
    CLOSE dept_cursor;
END;
/

-------------------------------------
--- V2
-------------------------------------
SET SERVEROUTPUT ON;

DECLARE
    v_deptno DEPT.N_DEPT%TYPE;
    v_dname DEPT.NOM%TYPE;
    v_loc DEPT.LIEU%TYPE;
BEGIN
    -- Opening an explicit cursor for DEPT table
    FOR dept_rec IN (SELECT * FROM DEPT WHERE N_DEPT = 30) LOOP
        v_deptno := dept_rec.N_DEPT;
        v_dname := dept_rec.NOM;
        v_loc := dept_rec.LIEU;
    END LOOP;

    -- Displaying the values of the variables
    DBMS_OUTPUT.PUT_LINE('Department No: ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_dname);
    DBMS_OUTPUT.PUT_LINE('Department Location: ' || v_loc);
END;
/
