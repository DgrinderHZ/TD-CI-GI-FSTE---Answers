-- Pour le TP, CREATE TABLE, INSERT INTO

CREATE TABLE PILOTE (
    NUMPIL INT PRIMARY KEY,
    NOMPIL VARCHAR(50),
    ADR VARCHAR(50),
    SAL INT
);

CREATE TABLE AVION (
    NUMAV INT PRIMARY KEY,
    NOMAV VARCHAR(50),
    CAPACITE INT,
    LOC VARCHAR(50)
);

CREATE TABLE VOL (
    NUMVOL INT PRIMARY KEY,
    NUMPIL INT,
    NUMAV INT,
    VILLE_DEP VARCHAR(50),
    VILLE_ARR VARCHAR(50),
    H_DEP TIMESTAMP,
    H_ARR TIMESTAMP,
    FOREIGN KEY (NUMPIL) REFERENCES PILOTE(NUMPIL),
    FOREIGN KEY (NUMAV) REFERENCES AVION(NUMAV)
);

CREATE TABLE TRACK_VOLS (
    NUMPIL INT PRIMARY KEY,
    NB_VOLS INT
);

-- Data
INSERT INTO PILOTE (NUMPIL, NOMPIL, ADR, SAL) VALUES(1, 'Jean Dupont', 'Er-Rachidia', 50000);
INSERT INTO PILOTE (NUMPIL, NOMPIL, ADR, SAL) VALUES(2, 'Alice Martin', 'Casablanca', 60000);
INSERT INTO PILOTE (NUMPIL, NOMPIL, ADR, SAL) VALUES(3, 'Marc Durand', 'Er-Rachidia', 55000);

INSERT INTO AVION (NUMAV, NOMAV, CAPACITE, LOC) VALUES (1, 'Airbus A320', 150, 'Casablanca');
INSERT INTO AVION (NUMAV, NOMAV, CAPACITE, LOC) VALUES (2, 'Boeing 737', 180, 'Er-Rachidia');
INSERT INTO AVION (NUMAV, NOMAV, CAPACITE, LOC) VALUES (3, 'Cessna 172', 4, 'Rabat');

INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES
(1, 1, 1, 'Er-Rachidia', 'Casablanca', TO_TIMESTAMP('2024-06-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES
(2, 2, 2, 'Casablanca', 'Marrakech', TO_TIMESTAMP('2024-06-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO VOL (NUMVOL, NUMPIL, NUMAV, VILLE_DEP, VILLE_ARR, H_DEP, H_ARR) VALUES
(3, 3, 3, 'Er-Rachidia', 'Rabat', TO_TIMESTAMP('2024-06-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-06-01 13:00:00', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TRACK_VOLS (NUMPIL, NB_VOLS) VALUES(1, 0);
INSERT INTO TRACK_VOLS (NUMPIL, NB_VOLS) VALUES(2, 0);
INSERT INTO TRACK_VOLS (NUMPIL, NB_VOLS) VALUES(3, 0);