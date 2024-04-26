----------- SESSION 1

SELECT * FROM EMP;

-- Tentative de mise à jour dans la table EMP qui ne vous appartient pas (va échouer)
UPDATE root.EMP 
SET salaire = 10000
WHERE nom = 'ALAOUI';

UPDATE root.EMP 
SET fonction = 'prof'
WHERE nom = 'ALAOUI';
commit;



------------ SESSION 2
 -- Tentative d'insertion dans la table EMP qui ne vous appartient pas (va échouer)
INSERT INTO EMP (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('ALAOUI3', 8003, 'Poste', 7890, SYSDATE, 5000, 2000, 20);

SELECT * FROM EMP;

commit;

-- Tentative de mise à jour dans la table EMP qui ne vous appartient pas (va échouer)
UPDATE root.EMP 
SET salaire = 10000
WHERE nom = 'ALAOUI';

SELECT * FROM EMP
WHERE nom = 'ALAOUI' FOR UPDATE of fonction;
