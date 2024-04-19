-- Créer un index avec unicité sur la colonne nom
CREATE UNIQUE INDEX idx_nom ON emp(nom);

-- Créer un index sur la colonne dept
CREATE INDEX idx_dept ON emp(dept);

-- Supprimer l'index de la colonne NOM
DROP INDEX idx_nom;



-- Accorder l'autorisation de modification mutuelle sur la table EMP (2eme user = root1)
GRANT SELECT, INSERT, UPDATE ON root.EMP TO user2;

-- schema name
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;













