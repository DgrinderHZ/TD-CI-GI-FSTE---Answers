-- 1. Cr�ation de la vue V_EMP
CREATE VIEW V_EMP AS
SELECT e.num AS matricule, e.nom, e.n_dept AS numero_departement,
       (e.salaire + NVL(e.comm, 0)) AS gains,
       d.lieu AS lieu_departement
FROM emp e
JOIN dept d ON e.n_dept = d.n_dept;

-- 2. S�lection des lignes de V_EMP o� le salaire total est sup�rieur � 10.000 DH
SELECT *
FROM V_EMP
WHERE gains > 10000;

-- 3. Essayez de mettre � jour le nom de l'employ� MARTIN � travers la vue V_EMP.
-- Cette op�ration n'est pas possible directement via une vue.
UPDATE V_EMP
SET nom = 'Martin'
WHERE nom = 'test';


-- 4. Cr�ation de la vue VEMP10 pour les employ�s du d�partement 10
CREATE VIEW VEMP10 AS
SELECT *
FROM EMP
WHERE n_dept = 10;

-- Insertion de l'employ� ALAOUI dans le d�partement 20
INSERT INTO VEMP10 (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('ALAOUI', 8000, 'Poste', 7890, SYSDATE, 5000, 2000, 20);

-- 5. D�truisez la vue VEMP10
DROP VIEW VEMP10;

-- Recr�ez la vue VEMP10 avec l'option CHECK
CREATE VIEW VEMP10 AS
SELECT *
FROM EMP
WHERE n_dept = 10
WITH CHECK OPTION;

-- 6. Essayez d'ins�rer un employ� HACHIMI pour le d�partement 30
-- L'insertion �chouera car la vue VEMP10 est bas�e sur la condition o� le num�ro du d�partement est �gal � 10.
INSERT INTO VEMP10 (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('HACHIMI', 1234, 'Poste', 7890, SYSDATE, 5000, 2000, 30);


-- Essayez de modifier le d�partement d'un employ� visualis� � l'aide de cette vue.
-- Cette op�ration n'est pas possible directement via une vue.
UPDATE VEMP10
SET n_dept = 30
WHERE nom = 'Test2';

-- 7. Liste des salaires des employ�s avec le pourcentage par rapport au total des salaires de leur d�partement
CREATE VIEW TotalSalairesDept AS
SELECT n_dept, SUM(salaire) AS total_salaire_dept
FROM emp
GROUP BY n_dept;

SELECT e.nom, e.salaire, 
       (e.salaire / t.total_salaire_dept * 100) AS pourcentage_salaire
FROM emp e
JOIN TotalSalairesDept t ON e.n_dept = t.n_dept;


-- 7.Vous pourrez chercher une autre solution qui n'utilise pas de vue mais un select embo�t� dans le from.
SELECT e.nom, e.salaire, 
       (e.salaire / t.total_salaire_dept * 100) AS pourcentage_salaire
FROM (
    SELECT n_dept, SUM(salaire) AS total_salaire_dept
    FROM emp
    GROUP BY n_dept
) t
JOIN emp e ON e.n_dept = t.n_dept;


