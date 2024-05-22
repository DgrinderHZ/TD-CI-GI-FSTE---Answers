-- Table DISQUE
CREATE TABLE DISQUE (
    nom VARCHAR2(50) PRIMARY KEY,
    capacite NUMBER,
    vitesse NUMBER,
    fabricant VARCHAR2(100)
);

-- Table PARTITION
CREATE TABLE PARTITION (
    nomDisque VARCHAR2(50),
    nomPartition VARCHAR2(50),
    taille NUMBER,
    PRIMARY KEY (nomDisque, nomPartition),
    FOREIGN KEY (nomDisque) REFERENCES DISQUE(nom)
);

-- Insertion d'un disque
INSERT INTO DISQUE (nom, capacite, vitesse, fabricant) VALUES ('Disque1', 1000, 7200, 'FabricantA');

-- Insertion de deux partitions pour ce disque
INSERT INTO PARTITION (nomDisque, nomPartition, taille) VALUES ('Disque1', 'Partition1', 400);
INSERT INTO PARTITION (nomDisque, nomPartition, taille) VALUES ('Disque1', 'Partition2', 300);


-- Exercice 6 : Déclencheur pour vérifier la taille des partitions
CREATE OR REPLACE TRIGGER trgr_verifier_partition
BEFORE INSERT ON PARTITION
FOR EACH ROW
DECLARE
    v_capacite_disque NUMBER;
    v_taille_partitions NUMBER;
    v_taille_total NUMBER;
BEGIN

    -- Récupérer la capacité de disque en question
    SELECT capacite INTO v_capacite_disque
    FROM DISQUE
    WHERE nom = :NEW.nomDisque;
    
    -- Récupérer la taille totale des partitions sur le disque concerné 
    SELECT SUM(taille) INTO v_taille_partitions
    FROM PARTITION
    WHERE nomDisque = :NEW.nomDisque;
    
    -- Ajouter la taille la partition qui est en cours d'être ajoutée
    v_taille_total := v_taille_partitions + :NEW.taille;
    
    IF v_taille_total > v_capacite_disque THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erreur : La taille totale des partitions dépasse la capacité du disque.');
        -- vous pouvez utiliser les exceptions aussi
    END IF;
    
END;
/

-- Après création de trigger
INSERT INTO PARTITION (nomDisque, nomPartition, taille) VALUES ('Disque1', 'Partition3', 500);