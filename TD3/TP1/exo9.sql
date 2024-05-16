SET SERVEROUTPUT ON;

-- Déclaration d'un enregistrement
DECLARE
    TYPE employee_record IS RECORD (
        nom emp.nom%TYPE,
        job emp.fonction%TYPE,
        salaire emp.salaire%TYPE
    );

    -- Déclaration d'une variable de type enregistrement
    v_employee employee_record;
BEGIN
    -- Sélection des informations de l'employé 'Alaoui'
    SELECT nom, fonction, salaire
    INTO v_employee.nom, v_employee.job, v_employee.salaire
    FROM emp
    WHERE nom = 'ALAOUI';

    -- Affichage des informations de l'employé 'Alaoui'
    DBMS_OUTPUT.PUT_LINE('Nom : ' || v_employee.nom);
    DBMS_OUTPUT.PUT_LINE('Job : ' || v_employee.job);
    DBMS_OUTPUT.PUT_LINE('Salaire : ' || v_employee.salaire);
END;
/
