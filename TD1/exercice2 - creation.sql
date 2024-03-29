CREATE TABLE produit (
    ref_prod INT PRIMARY KEY,
    nom_prod VARCHAR2(50),
    couleur VARCHAR2(50),
    poids FLOAT
);

CREATE TABLE usine (
    ref_usine INT PRIMARY KEY,
    nom_usine VARCHAR2(50),
    ville VARCHAR2(50)
);

CREATE TABLE magasin (
    ref_mag INT PRIMARY KEY,
    nom_mag VARCHAR2(50),
    ville VARCHAR2(50)
);

CREATE TABLE provenance (
    ref_prod INT,
    ref_usine INT,
    ref_mag INT,
    quantite INT,
    FOREIGN KEY (ref_prod) REFERENCES produit(ref_prod),
    FOREIGN KEY (ref_usine) REFERENCES usine(ref_usine),
    FOREIGN KEY (ref_mag) REFERENCES magasin(ref_mag)
);
