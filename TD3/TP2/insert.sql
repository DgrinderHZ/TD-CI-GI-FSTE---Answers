-- Insert data into INDIVIDU
INSERT INTO INDIVIDU (numIndividu, nomIndividu, prenomIndividu) VALUES (1, 'Smith', 'John');
INSERT INTO INDIVIDU (numIndividu, nomIndividu, prenomIndividu) VALUES (2, 'Doe', 'Jane');
INSERT INTO INDIVIDU (numIndividu, nomIndividu, prenomIndividu) VALUES (3, 'Brown', 'Charlie');

-- Insert data into FILM
INSERT INTO FILM (numFilm, titre, realisateur) VALUES (1, 'The Unique Film', 1);
INSERT INTO FILM (numFilm, titre, realisateur) VALUES (2, 'Another Film', 2);
INSERT INTO FILM (numFilm, titre, realisateur) VALUES (3, 'Third Film', 3);

-- Insert data into EXEMPLAIRE for 'The Unique Film'
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (1, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (2, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (3, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (4, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (5, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (6, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (7, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (8, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (9, 1, 'DVD', 'N', NULL, 'DVD');
INSERT INTO EXEMPLAIRE (numExemplaire, numFilm, codeSupport, vo, probleme, detailSupport) VALUES (10, 1, 'DVD', 'N', NULL, 'DVD');

-- Insert data into GENRE
INSERT INTO GENRE (codeGenre, libelleGenre) VALUES ('AC', 'Action');
INSERT INTO GENRE (codeGenre, libelleGenre) VALUES ('CO', 'Comedy');
INSERT INTO GENRE (codeGenre, libelleGenre) VALUES ('DR', 'Drama');

-- Insert data into GENREFILM
INSERT INTO GENREFILM (numFilm, codeGenre) VALUES (1, 'AC');
INSERT INTO GENREFILM (numFilm, codeGenre) VALUES (2, 'CO');
INSERT INTO GENREFILM (numFilm, codeGenre) VALUES (3, 'DR');

-- Insert data into CLIENT
INSERT INTO CLIENT (login, nomClient, prenomClient, motDePasse, adresse) VALUES ('jdoe', 'Doe', 'John', 'password123', '123 Elm St');
INSERT INTO CLIENT (login, nomClient, prenomClient, motDePasse, adresse) VALUES ('asmith', 'Smith', 'Alice', 'password456', '456 Oak St');

-- Insert data into LOCATION
INSERT INTO LOCATION (numExemplaire, dateLocation, login, dateEnvoi, dateRetour) VALUES (1, TO_DATE('2023-05-20', 'YYYY-MM-DD'), 'jdoe', TO_DATE('2023-05-21', 'YYYY-MM-DD'), TO_DATE('2023-05-28', 'YYYY-MM-DD'));
INSERT INTO LOCATION (numExemplaire, dateLocation, login, dateEnvoi, dateRetour) VALUES (2, TO_DATE('2023-05-22', 'YYYY-MM-DD'), 'asmith', TO_DATE('2023-05-23', 'YYYY-MM-DD'), TO_DATE('2023-05-30', 'YYYY-MM-DD'));
