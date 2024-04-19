-- Tentative d'insertion dans la table EMP qui ne vous appartient pas (va échouer)
INSERT INTO root.EMP (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES ('ALAOUI2', 8000, 'Poste', 7890, SYSDATE, 5000, 2000, 20);

-- Tentative de mise à jour dans la table EMP qui ne vous appartient pas (va échouer)
UPDATE root.EMP 
SET salaire = 10000
WHERE nom = 'ALAOUI2';

-- (Executer sur la session de l'autre utilisateur) Accorder l'autorisation de modification mutuelle sur la table EMP (2eme user = root1)
GRANT INSERT, UPDATE ON EMP TO root1;
GRANT INSERT, UPDATE ON EMP TO root;

