-- 1. Création de la vue V_EMP
CREATE VIEW V_EMP AS
SELECT e.num AS matricule, e.nom, e.n_dept AS numero_departement,
       (e.salaire + NVL(e.comm, 0)) AS gains,
       d.lieu AS lieu_departement
FROM emp e
JOIN dept d ON e.n_dept = d.n_dept;

-- 2. Sélection des lignes de V_EMP où le salaire total est supérieur à 10.000 DH
SELECT *
FROM V_EMP
WHERE gains > 10000;

-- 3. Essayez de mettre à jour le nom de l'employé MARTIN à travers la vue V_EMP.
-- Cette opération n'est pas possible directement via une vue.
UPDATE V_EMP
SET nom = 'Martin'
WHERE nom = 'test';


-- 4. Création de la vue VEMP10 pour les employés du département 10
CREATE VIEW VEMP10 AS
SELECT *
FROM EMP
WHERE n_dept = 10;

-- Insertion de l'employé ALAOUI dans le département 20
INSERT INTO VEMP10 (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('ALAOUI', 8000, 'Poste', 7890, SYSDATE, 5000, 2000, 20);

-- 5. Détruisez la vue VEMP10
DROP VIEW VEMP10;

-- Recréez la vue VEMP10 avec l'option CHECK
CREATE VIEW VEMP10 AS
SELECT *
FROM EMP
WHERE n_dept = 10
WITH CHECK OPTION;

-- 6. Essayez d'insérer un employé HACHIMI pour le département 30
-- L'insertion échouera car la vue VEMP10 est basée sur la condition où le numéro du département est égal à 10.
INSERT INTO VEMP10 (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('HACHIMI', 1234, 'Poste', 7890, SYSDATE, 5000, 2000, 30);


-- Essayez de modifier le département d'un employé visualisé à l'aide de cette vue.
-- Cette opération n'est pas possible directement via une vue.
UPDATE VEMP10
SET n_dept = 30
WHERE nom = 'Test2';

-- 7. Liste des salaires des employés avec le pourcentage par rapport au total des salaires de leur département
CREATE VIEW TotalSalairesDept AS
SELECT n_dept, SUM(salaire) AS total_salaire_dept
FROM emp
GROUP BY n_dept;

SELECT e.nom, e.salaire, 
       (e.salaire / t.total_salaire_dept * 100) AS pourcentage_salaire
FROM emp e
JOIN TotalSalairesDept t ON e.n_dept = t.n_dept;


-- 7.Vous pourrez chercher une autre solution qui n'utilise pas de vue mais un select emboîté dans le from.
SELECT e.nom, e.salaire, 
       (e.salaire / t.total_salaire_dept * 100) AS pourcentage_salaire
FROM (
    SELECT n_dept, SUM(salaire) AS total_salaire_dept
    FROM emp
    GROUP BY n_dept
) t
JOIN emp e ON e.n_dept = t.n_dept;


