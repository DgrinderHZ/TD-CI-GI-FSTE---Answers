--  (a) Donnez la liste des noms des pilotes :
SELECT NOMPIL FROM PILOTE;

--  (b) Donnez la liste des villes desservies (arriv�e ou d�part) :
SELECT DISTINCT VILLE_DEP AS VILLES FROM VOL
UNION
SELECT DISTINCT VILLE_ARR FROM VOL;

--  (c) Donnez la liste des villes qui sont desservies en arriv�e et en d�part :
SELECT VILLE_DEP AS VILLES
FROM VOL
INTERSECT
SELECT VILLE_ARR
FROM VOL;

--  (d) Donnez la liste des villes qui sont desservies uniquement en d�part :
SELECT DISTINCT VILLE_DEP AS VILLES
FROM VOL
WHERE VILLE_DEP NOT IN (SELECT VILLE_ARR FROM VOL);

--  (e) Donnez la liste des avions (leurs num�ros) dont la capacit� est sup�rieure � 350 passagers :
SELECT NUMAV
FROM AVION
WHERE CAPACITE > 350;

--  (f) Quels sont les num�ros et noms des avions localis�s � Nice ?
SELECT NUMAV, NOMAV
FROM AVION
WHERE LOC = 'Nice';

--  (g) Quels sont les num�ros des pilotes en service et les villes de d�part de leurs vols ?
SELECT DISTINCT P.NUMPIL, V.VILLE_DEP
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL;

--  (h) Quel est le nom des pilotes domicili�s � Paris dont le salaire est sup�rieur � 2500 euros ?
SELECT NOMPIL
FROM PILOTE
WHERE ADR = 'Paris' AND SAL > 2500;

--  (i) Donnez les num�ros et nom des pilotes homonymes (m�me nom) :
SELECT NUMPIL, NOMPIL
FROM PILOTE 
WHERE NOMPIL IN (
    SELECT NOMPIL
    FROM PILOTE
    GROUP BY NOMPIL
    HAVING COUNT(*) > 1
);

--  (j) Quels sont les num�ros des pilotes qui ne sont pas en service ?
SELECT NUMPIL
FROM PILOTE
WHERE NUMPIL NOT IN (SELECT DISTINCT NUMPIL FROM VOL);

--  (k) Quels sont les vols (num�ro, ville de d�part) effectu�s par les pilotes de num�ro 100 et 204 ?
SELECT NUMVOL, VILLE_DEP
FROM VOL
WHERE NUMPIL IN (100, 204);

--  (l) Quels sont les num�ros des pilotes en service qui ne s'appellent pas Durand ?
SELECT NUMPIL
FROM VOL
WHERE NUMPIL IN (SELECT NUMPIL FROM PILOTE WHERE NOMPIL != 'Durand');

--  (m) Donnez le num�ro des vols effectu�s au d�part de Nice par des pilotes Ni�ois ?
SELECT NUMVOL
FROM VOL
WHERE VILLE_DEP = 'Nice' AND NUMPIL IN (SELECT NUMPIL FROM PILOTE WHERE ADR = 'Nice');

--  (n) Quels sont les vols effectu�s par un avion qui n'est pas localis� � Nice ?
SELECT NUMVOL
FROM VOL
WHERE NUMAV NOT IN (SELECT NUMAV FROM AVION WHERE LOC = 'Nice');

--  (o) Quels sont les pilotes (num�ro et nom) assurant au moins un vol au d�part de Nice avec un avion de capacit� sup�rieure � 300 places ?
SELECT DISTINCT P.NUMPIL, P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE V.VILLE_DEP = 'Nice' AND A.CAPACITE > 300;

--  (p) Quels sont les noms des pilotes domicili�s � Paris assurant un vol au d�part de Nice avec un Airbus A380 ?
SELECT DISTINCT P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE P.ADR = 'Paris' AND V.VILLE_DEP = 'Nice' AND A.NOMAV = 'Airbus A380';

--  (q) Quels sont les num�ros des vols effectu�s par un pilote Ni�ois au d�part ou � l'arriv�e de Nice avec un avion localis� � Paris ?
SELECT DISTINCT V.NUMVOL
FROM VOL V
JOIN PILOTE P ON V.NUMPIL = P.NUMPIL
JOIN AVION A ON V.NUMAV = A.NUMAV
WHERE (V.VILLE_DEP = 'Nice' OR V.VILLE_ARR = 'Nice')
AND P.ADR = 'Nice' AND A.LOC = 'Paris';

--  (r) Quels sont les pilotes (num�ro et nom) habitant dans la m�me ville que le pilote Dupont (on suppose qu'il n'y en a qu'un !) ?
SELECT NUMPIL, NOMPIL
FROM PILOTE
WHERE ADR = (SELECT ADR FROM PILOTE WHERE NOMPIL = 'Dupont');

--  (s) Quelles sont les villes desservies � partir de la ville d'arriv�e d'un vol au d�part de Paris ?
SELECT DISTINCT V.VILLE_ARR
FROM VOL V
WHERE V.VILLE_DEP = 'Paris';

--  (t) Quels sont les appareils (leur num�ro) localis�s dans la m�me ville que l'avion num�ro 100 ?
SELECT NUMAV
FROM AVION
WHERE LOC = (SELECT LOC FROM AVION WHERE NUMAV = 100);

--  (u) Quels sont les num�ros et noms des pilotes qui effectuent un vol au d�part de leur ville de r�sidence ?
SELECT P.NUMPIL, P.NOMPIL
FROM PILOTE P
JOIN VOL V ON P.NUMPIL = V.NUMPIL
WHERE P.ADR = V.VILLE_DEP;