CREATE TABLE INDIVIDU (
    numIndividu INT PRIMARY KEY,
    nomIndividu VARCHAR2(255),
    prenomIndividu VARCHAR2(255)
);

CREATE TABLE FILM (
    numFilm INT PRIMARY KEY,
    titre VARCHAR2(255),
    realisateur INT,
    FOREIGN KEY (realisateur) REFERENCES INDIVIDU(numIndividu)
);

CREATE TABLE ACTEUR (
    numFilm INT,
    numIndividu INT,
    PRIMARY KEY (numFilm, numIndividu),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm),
    FOREIGN KEY (numIndividu) REFERENCES INDIVIDU(numIndividu)
);

CREATE TABLE GENRE (
    codeGenre VARCHAR2(5) PRIMARY KEY,
    libelleGenre VARCHAR2(255)
);

CREATE TABLE GENREFILM (
    numFilm INT,
    codeGenre VARCHAR2(5) ,
    PRIMARY KEY (numFilm, codeGenre),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm),
    FOREIGN KEY (codeGenre) REFERENCES GENRE(codeGenre)
);

CREATE TABLE CLIENT (
    login VARCHAR2(255) PRIMARY KEY,
    nomClient VARCHAR2(255),
    prenomClient VARCHAR2(255),
    motDePasse VARCHAR2(255),
    adresse VARCHAR2(255)
);

CREATE TABLE EXEMPLAIRE (
    numExemplaire INT PRIMARY KEY,
    numFilm INT,
    codeSupport VARCHAR2(255),
    vo CHAR(1), -- Y: Yes, N: No
    probleme VARCHAR2(1000),
    detailSupport VARCHAR2(1000),
    FOREIGN KEY (numFilm) REFERENCES FILM(numFilm)
);

CREATE TABLE LOCATION (
    numExemplaire INT,
    dateLocation DATE,
    login VARCHAR2(255),
    dateEnvoi DATE,
    dateRetour DATE,
    PRIMARY KEY (numExemplaire, dateLocation),
    FOREIGN KEY (numExemplaire) REFERENCES EXEMPLAIRE(numExemplaire),
    FOREIGN KEY (login) REFERENCES CLIENT(login)
);
