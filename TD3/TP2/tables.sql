-- Table CLIENT
CREATE TABLE CLIENT (
    login VARCHAR2(50) PRIMARY KEY,
    nomClient VARCHAR2(100),
    prenomClient VARCHAR2(100),
    motDePasse VARCHAR2(100),
    adresse VARCHAR2(255)
);

-- Table FILM
CREATE TABLE FILM (
    numFilm NUMBER PRIMARY KEY,
    titre VARCHAR2(255),
    realisateur VARCHAR2(100)
);

-- Table GENRE
CREATE TABLE GENRE (
    numGenre NUMBER PRIMARY KEY,
    libelleGenre VARCHAR2(100)
);

-- Table GENREFILM
CREATE TABLE GENREFILM (
    numFilm NUMBER,
    numGenre NUMBER,
    PRIMARY KEY (numFilm, numGenre),
    FOREIGN KEY (numGenre) REFERENCES GENRE(numGenre),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm)
);


-- Table INDIVIDU
CREATE TABLE INDIVIDU (
    numIndividu NUMBER PRIMARY KEY,
    nomIndividu VARCHAR2(100),
    prenomIndividu VARCHAR2(100)
);

-- Table ACTEUR
CREATE TABLE ACTEUR (
    numFilm NUMBER,
    numIndividu NUMBER,
    PRIMARY KEY (numFilm, numIndividu),
    FOREIGN KEY (numIndividu) REFERENCES INDIVIDU(numIndividu),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm)
);


-- Table EXEMPLAIRE
CREATE TABLE EXEMPLAIRE (
    numExemplaire NUMBER PRIMARY KEY,
    numFilm NUMBER,
    codeSupport NUMBER,
    vo NUMBER(1),
    probleme VARCHAR2(200),
    detailSupport VARCHAR2(200),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm)
);

-- Table LOCATION
CREATE TABLE LOCATION (
    numExemplaire NUMBER,
    dateLocation DATE,
    login VARCHAR2(50),
    dateEnvoi DATE,
    dateRetour DATE,
    PRIMARY KEY (numExemplaire, dateLocation),
    FOREIGN KEY (numExemplaire) REFERENCES EXEMPLAIRE(numExemplaire),
    FOREIGN KEY (login) REFERENCES CLIENT(login)
);


------------------------------------------
INSERT INTO CLIENT (login, nomClient, prenomClient, motDePasse, adresse)
VALUES ('client1', 'Doe', 'John', 'password123', '123 Main Street');

INSERT INTO CLIENT (login, nomClient, prenomClient, motDePasse, adresse)
VALUES ('client2', 'Smith', 'Alice', 'qwerty', '456 Elm Street');
-----------------------
INSERT INTO FILM (numFilm, titre, realisateur)
VALUES (1, 'Le Seigneur des Anneaux', 'Peter Jackson');

INSERT INTO FILM (numFilm, titre, realisateur)
VALUES (2, 'Inception', 'Christopher Nolan');
-----------------------
INSERT INTO GENRE (numGenre, libelleGenre)
VALUES (1, 'Fantasy');

INSERT INTO GENRE (numGenre, libelleGenre)
VALUES (2, 'Science Fiction');
-----------------------
INSERT INTO GENREFILM (numFilm, numGenre)
VALUES (1, 1); -- Le Seigneur des Anneaux est du genre Fantasy

INSERT INTO GENREFILM (numFilm, numGenre)
VALUES (2, 2); -- Inception est du genre Science Fiction

--------------------
INSERT INTO INDIVIDU (numIndividu, nomIndividu, prenomIndividu)
VALUES (1, 'Depp', 'Johnny');

INSERT INTO INDIVIDU (numIndividu, nomIndividu, prenomIndividu)
VALUES (2, 'DiCaprio', 'Leonardo');
--------------
INSERT INTO ACTEUR (numFilm, numIndividu)
VALUES (1, 1); -- Johnny Depp joue dans Le Seigneur des Anneaux

INSERT INTO ACTEUR (numFilm, numIndividu)
VALUES (2, 2); -- Leonardo DiCaprio joue dans Inception
----------------------------
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport)
VALUES (1, 1, 123, 1, 'Aucun', 'DVD');

INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport)
VALUES (2, 1, 124, 0, 'Rayures', 'Blu-ray');
---------------
INSERT INTO LOCATION (numExemplaire, dateLocation, login, dateEnvoi, dateRetour)
VALUES (1, TO_DATE('2023-04-10', 'YYYY-MM-DD'), 'client1', TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-15', 'YYYY-MM-DD'));

INSERT INTO LOCATION (numExemplaire, dateLocation, login, dateEnvoi, dateRetour)
VALUES (2, TO_DATE('2023-04-12', 'YYYY-MM-DD'), 'client2', TO_DATE('2023-04-12', 'YYYY-MM-DD'), TO_DATE('2023-04-18', 'YYYY-MM-DD'));








