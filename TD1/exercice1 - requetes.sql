--  (a) Donnez la liste des noms des pilotes :
SELECT NOMPIL FROM PILOTE;

--  (b) Donnez la liste des villes desservies (arrivée ou départ) :
SELECT DISTINCT VILLE_DEP AS VILLES FROM VOL
UNION
SELECT DISTINCT VILLE_ARR FROM VOL;

--  (c) Donnez la liste des villes qui sont desservies en arrivée et en départ :
SELECT VILLE_DEP AS VILLES
FROM VOL
INTERSECT
SELECT VILLE_ARR
FROM VOL;

--  (d) Donnez la liste des villes qui sont desservies uniquement en départ :
SELECT DISTINCT VILLE_DEP AS VILLES
FROM VOL
WHERE VILLE_DEP NOT IN (SELECT VILLE_ARR FROM VOL);

--  (e) Donnez la liste des avions (leurs numéros) dont la capacité est supérieure à  350 passagers :
SELECT NUMAV
FROM AVION
WHERE CAPACITE > 350;

--  (f) Quels sont les numéros et noms des avions localisés à  Nice ?
SELECT NUMAV, NOMAV
FROM AVION
WHERE LOC = 'Nice';

--  (g) Quels sont les numéros des pilotes en service et les villes de départ de leurs vols ?
SELECT DISTINCT P.NUMPIL, V.VILLE_DEP
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL;

--  (h) Quel est le nom des pilotes domiciliés à  Paris dont le salaire est supérieur à  2500 euros ?
SELECT NOMPIL
FROM PILOTE
WHERE ADR = 'Paris' AND SAL > 2500;

--  (i) Donnez les numéros et nom des pilotes homonymes (même nom) :
SELECT NUMPIL, NOMPIL
FROM PILOTE 
WHERE NOMPIL IN (
    SELECT NOMPIL
    FROM PILOTE
    GROUP BY NOMPIL
    HAVING COUNT(*) > 1
);

--  (j) Quels sont les numéros des pilotes qui ne sont pas en service ?
SELECT NUMPIL
FROM PILOTE
WHERE NUMPIL NOT IN (SELECT DISTINCT NUMPIL FROM VOL);

--  (k) Quels sont les vols (numéro, ville de départ) effectués par les pilotes de numéro 100 et 204 ?
SELECT NUMVOL, VILLE_DEP
FROM VOL
WHERE NUMPIL IN (100, 204);

--  (l) Quels sont les numéros des pilotes en service qui ne s'appellent pas Durand ?
SELECT NUMPIL
FROM VOL
WHERE NUMPIL IN (SELECT NUMPIL FROM PILOTE WHERE NOMPIL != 'Durand');

--  (m) Donnez le numéro des vols effectués au départ de Nice par des pilotes Niçois ?
SELECT NUMVOL
FROM VOL
WHERE VILLE_DEP = 'Nice' AND NUMPIL IN (SELECT NUMPIL FROM PILOTE WHERE ADR = 'Nice');

--  (n) Quels sont les vols effectués par un avion qui n'est pas localisé à  Nice ?
SELECT NUMVOL
FROM VOL
WHERE NUMAV NOT IN (SELECT NUMAV FROM AVION WHERE LOC = 'Nice');

--  (o) Quels sont les pilotes (numéro et nom) assurant au moins un vol au départ de Nice avec un avion de capacité supérieure à  300 places ?
SELECT DISTINCT P.NUMPIL, P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE V.VILLE_DEP = 'Nice' AND A.CAPACITE > 300;

--  (p) Quels sont les noms des pilotes domiciliés à  Paris assurant un vol au départ de Nice avec un Airbus A380 ?
SELECT DISTINCT P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE P.ADR = 'Paris' AND V.VILLE_DEP = 'Nice' AND A.NOMAV = 'Airbus A380';

--  (q) Quels sont les numéros des vols effectués par un pilote Niçois au départ ou à  l'arrivée de Nice avec un avion localisé à  Paris ?
SELECT DISTINCT V.NUMVOL
FROM VOL V
JOIN PILOTE P ON V.NUMPIL = P.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE (V.VILLE_DEP = 'Nice' OR V.VILLE_ARR = 'Nice')
AND P.ADR = 'Nice' AND A.LOC = 'Paris';

--  (r) Quels sont les pilotes (numéro et nom) habitant dans la même ville que le pilote Dupont (on suppose qu'il n'y en a qu'un !) ?
SELECT NUMPIL, NOMPIL
FROM PILOTE
WHERE ADR = (SELECT ADR FROM PILOTE WHERE NOMPIL = 'Dupont');

--  (s) Quelles sont les villes desservies à  partir de la ville d'arrivée d'un vol au départ de Paris ?
SELECT DISTINCT V.VILLE_ARR
FROM VOL V
WHERE V.VILLE_DEP = 'Paris';

--  (t) Quels sont les appareils (leur numéro) localisés dans la même ville que l'avion numéro 100 ?
SELECT NUMAV
FROM AVION
WHERE LOC = (SELECT LOC FROM AVION WHERE NUMAV = 100);

--  (u) Quels sont les numéros et noms des pilotes qui effectuent un vol au départ de leur ville de résidence ?
SELECT P.NUMPIL, P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
WHERE P.ADR = V.VILLE_DEP;