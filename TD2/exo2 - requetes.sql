-- Créer un index avec unicité sur la colonne nom
CREATE UNIQUE INDEX idx_nom ON emp(nom);

-- Créer un index sur la colonne dept
CREATE INDEX idx_dept ON emp(dept);

-- Supprimer l'index de la colonne NOM
DROP INDEX idx_nom;



-- our monter le nom de schema de la session
SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;













