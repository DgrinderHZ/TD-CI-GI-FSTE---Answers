CREATE TABLE PILOTE (
    NUMPIL INT PRIMARY KEY,
    NOMPIL VARCHAR2(50),
    ADR VARCHAR2(50),
    SAL INT
);

CREATE TABLE AVION (
    NUMAV INT PRIMARY KEY,
    NOMAV VARCHAR2(50),
    CAPACITE INT,
    LOC VARCHAR2(50)
);

CREATE TABLE VOL (
    NUMVOL INT PRIMARY KEY,
    NUMPIL INT,
    NUMAV INT,
    VILLE_DEP VARCHAR2(50),
    VILLE_ARR VARCHAR2(50),
    H_DEP INT,
    H_ARR INT,
    FOREIGN KEY (NUMPIL) REFERENCES PILOTE(NUMPIL),
    FOREIGN KEY (NUMAV) REFERENCES AVION(NUMAV)
);

-- Pour spécifier les contraintes sur les attributs H_DEP (heure de départ du vol) 
-- et H_ARR (heure d'arrivée du vol) afin qu'ils soient des nombres entiers compris entre 0 et 23, 
-- vous pouvez utiliser des contraintes CHECK lors de la création de la table VOL. Voici comment vous pouvez le faire :
CREATE TABLE VOL (
    NUMVOL INT PRIMARY KEY,
    NUMPIL INT,
    NUMAV INT,
    VILLE_DEP VARCHAR2(50),
    VILLE_ARR VARCHAR2(50),
    H_DEP INT CHECK (H_DEP BETWEEN 0 AND 23),
    H_ARR INT CHECK (H_ARR BETWEEN 0 AND 23),
    FOREIGN KEY (NUMPIL) REFERENCES PILOTE(NUMPIL),
    FOREIGN KEY (NUMAV) REFERENCES AVION(NUMAV)
);
