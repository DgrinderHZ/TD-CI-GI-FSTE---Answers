-- Insertion des données dans la table produit
INSERT INTO produit (ref_prod, nom_prod, couleur, poids)
VALUES
(1, 'Produit A', 'rouge', 10.5);

INSERT INTO produit (ref_prod, nom_prod, couleur, poids)
VALUES
(2, 'Produit B', 'bleu', 15.2);

INSERT INTO produit (ref_prod, nom_prod, couleur, poids)
VALUES
(3, 'Produit C', 'vert', 12.8);

-- Insertion des données dans la table usine
INSERT INTO usine (ref_usine, nom_usine, ville)
VALUES
(101, 'Usine 1', 'Rabat');

INSERT INTO usine (ref_usine, nom_usine, ville)
VALUES
(102, 'Usine 2', 'Casablanca');

INSERT INTO usine (ref_usine, nom_usine, ville)
VALUES
(103, 'Usine 3', 'Marrakech');

-- Insertion des données dans la table magasin
INSERT INTO magasin (ref_mag, nom_mag, ville)
VALUES
(201, 'Magasin 1', 'Rabat');

INSERT INTO magasin (ref_mag, nom_mag, ville)
VALUES
(202, 'Magasin 2', 'Casablanca');

INSERT INTO magasin (ref_mag, nom_mag, ville)
VALUES
(203, 'Magasin 3', 'Marrakech');

-- Insertion des données dans la table provenance
INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite)
VALUES
(1, 101, 201, 50);

INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite)
VALUES
(2, 102, 202, 30);

INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite)
VALUES
(3, 103, 203, 40);

-- Insertion de données de test dans la table provenance
INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite) VALUES (1, 101, 201, 50);   -- produit 1, usine 101, magasin 201
INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite) VALUES (1, 101, 202, 30);   -- produit 1, usine 101, magasin 202
INSERT INTO provenance (ref_prod, ref_usine, ref_mag, quantite) VALUES (2, 102, 203, 40);   -- produit 2, usine 102, magasin 203
