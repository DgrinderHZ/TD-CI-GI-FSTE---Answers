

-- Création de la table dept
CREATE TABLE dept (
    n_dept NUMBER,
    nom VARCHAR2(50),
    lieu VARCHAR2(50),
    CONSTRAINT dept_pk PRIMARY KEY (n_dept)
);

-- Création de la table emp
CREATE TABLE emp (
    nom VARCHAR2(50),
    num NUMBER,
    fonction VARCHAR2(50),
    n_sup NUMBER,
    embauche DATE,
    salaire NUMBER,
    comm NUMBER,
    n_dept NUMBER,
    CONSTRAINT emp_pk PRIMARY KEY (num),
    CONSTRAINT emp_fk_dept FOREIGN KEY (n_dept) REFERENCES dept(n_dept)
);


-- Insertion de données de test dans la table dept

INSERT INTO dept (n_dept, nom, lieu) VALUES
(10, 'Comptabilité', 'New York');

INSERT INTO dept (n_dept, nom, lieu) VALUES
(20, 'Ressources Humaines', 'Los Angeles');

INSERT INTO dept (n_dept, nom, lieu) VALUES
(30, 'Ventes', 'Chicago');

INSERT INTO dept (n_dept, nom, lieu) VALUES
(40, 'Informatique', 'Houston');

-- Insertion de données de test dans la table emp
INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Smith', 7369, 'Commis', 7902, TO_DATE('17-12-1980', 'DD-MM-YYYY'), 800, NULL, 20);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Allen', 7499, 'Vendeur', 7698, TO_DATE('20-02-1981', 'DD-MM-YYYY'), 1600, 300, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Ward', 7521, 'Vendeur', 7698, TO_DATE('22-02-1981', 'DD-MM-YYYY'), 1250, 500, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Jones', 7566, 'Gestionnaire', 7839, TO_DATE('02-04-1981', 'DD-MM-YYYY'), 2975, NULL, 20);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Martin', 7654, 'Vendeur', 7698, TO_DATE('28-09-1981', 'DD-MM-YYYY'), 1250, 1400, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Blake', 7698, 'Directeur', NULL, TO_DATE('01-05-1981', 'DD-MM-YYYY'), 2850, NULL, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Clark', 7782, 'Gestionnaire', 7839, TO_DATE('09-06-1981', 'DD-MM-YYYY'), 2450, NULL, 10);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Scott', 7788, 'Analyste', 7566, TO_DATE('19-04-1987', 'DD-MM-YYYY'), 3000, NULL, 20);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('King', 7839, 'Président', NULL, TO_DATE('17-11-1981', 'DD-MM-YYYY'), 5000, NULL, 10);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Turner', 7844, 'Vendeur', 7698, TO_DATE('08-09-1981', 'DD-MM-YYYY'), 1500, 0, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Adams', 7876, 'Clerc', 7788, TO_DATE('23-05-1987', 'DD-MM-YYYY'), 1100, NULL, 20);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('James', 7900, 'Clerc', 7698, TO_DATE('03-12-1981', 'DD-MM-YYYY'), 950, NULL, 30);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Ford', 7902, 'Analyste', 7566, TO_DATE('05-12-1981', 'DD-MM-YYYY'), 3000, NULL, 20);

INSERT INTO emp (nom, num, fonction, n_sup, embauche, salaire, comm, n_dept) 
VALUES('Miller', 7934, 'Commis', 7782, TO_DATE('23-01-1982', 'DD-MM-YYYY'), 1300, NULL, 10);
