-- 1. La r�f�rence, le nom et la ville de toutes les usines de Rabat
SELECT ref_usine, nom_usine, ville
FROM usine
WHERE ville = 'Rabat';

-- 2. Les r�f�rences des magasins qui sont approvisionn�s (aliment�s) par l'usine de r�f�rence 101 en produit de r�f�rence 1
SELECT ref_mag
FROM provenance
WHERE ref_usine = 101 AND ref_prod = 1;

-- 3. La r�f�rence et le nom de tous les produits rouges
SELECT ref_prod, nom_prod
FROM produit
WHERE couleur = 'rouge';

-- 4. La r�f�rence et le nom de tous les produits dont le nom commence par "Produit"
SELECT ref_prod, nom_prod
FROM produit
WHERE nom_prod LIKE 'Produit%';

-- 5. La r�f�rence des magasins auxquels on livre quelque chose. Faites la requ�te sans pr�ciser DISTINCT puis avec
-- Sans DISTINCT
SELECT ref_mag
FROM provenance;

-- Avec DISTINCT
SELECT DISTINCT ref_mag
FROM provenance;

-- 6. La r�f�rence des magasins auxquels on ne livre rien (utilisez EXCEPT)
SELECT ref_mag
FROM magasin
EXCEPT
SELECT ref_mag
FROM provenance;

-- 7. Le nom et la couleur des produits livr�s par l'usine de r�f�rence 103. 
-- Faites la m�me requ�te avec NATURAL JOIN pour ne pas afficher deux fois le m�me produit, on peut utiliser DISTINCT ON (ref_prod) m�me si ref_prod n'est pas affich�
-- Avec JOIN
SELECT DISTINCT p.nom_prod, p.couleur
FROM provenance pr
JOIN produit p ON pr.ref_prod = p.ref_prod
WHERE pr.ref_usine = 103;

-- Avec NATURAL JOIN
SELECT DISTINCT ref_prod, nom_prod, couleur
FROM provenance pr
NATURAL JOIN produit p
WHERE pr.ref_usine = 103;


-- 8. Les r�f�rences des magasins qui sont approvisionn�s par l'usine de r�f�rence 102 en un produit rouge
SELECT DISTINCT pr.ref_mag
FROM provenance pr
JOIN produit p ON pr.ref_prod = p.ref_prod
WHERE pr.ref_usine = 102 AND p.couleur = 'rouge';

-- 9. Le poids de la livraison (renomm� poids_livraisons) en produit de r�f�rence 3 livr�s au magasin 203 par l'usine de r�f�rence 103
SELECT quantite * p.poids AS poids_livraisons
FROM provenance pr
JOIN produit p ON pr.ref_prod = p.ref_prod
WHERE pr.ref_usine = 103 AND pr.ref_mag = 203 AND pr.ref_prod = 3;

-- 10. Pour chaque produit, chaque magasin et chaque usine, le poids de livraison (renomm� poids_livraisons), la r�f�rence du produit, celle du magasin et celle de l'usine
-- Note: Donner le poids de livraison Pour chaque produit, chaque magasin et chaque usine.
SELECT pr.ref_prod, pr.ref_mag, pr.ref_usine, pr.quantite * p.poids AS poids_livraisons
FROM provenance pr
JOIN produit p ON pr.ref_prod = p.ref_prod;

-- 11. Les couples nom d'usine, nom de magasin qui sont dans la m�me ville avec le nom de la ville
SELECT u.nom_usine, m.nom_mag, u.ville
FROM usine u
JOIN magasin m ON u.ville = m.ville;

-- 12. Les couples de magasins (r�f�rence) qui s'approvisionnent du m�me produit fabriqu� par la m�me usine
-- Note: vous pouvez utiliser <>, < ou > pour la partie (p1.ref_mag <> p2.ref_mag)
SELECT p1.ref_mag, p2.ref_mag
FROM provenance p1
JOIN provenance p2 ON p1.ref_prod = p2.ref_prod AND p1.ref_usine = p2.ref_usine AND p1.ref_mag <> p2.ref_mag;

-- 13. La m�me chose en affichant les noms des magasins (utiliser NATURAL JOIN � bon escient)
-- Note: Faites des jointure deux fois avec la table magasin
SELECT m1.nom_mag, m2.nom_mag
FROM provenance p1
NATURAL JOIN provenance p2
JOIN magasin m1 ON p1.ref_mag = m1.ref_mag
JOIN magasin m2 ON p2.ref_mag = m2.ref_mag
WHERE p1.ref_prod = p2.ref_prod AND p1.ref_usine = p2.ref_usine AND p1.ref_mag <> p2.ref_mag;

-- 14. Les noms des magasins qui s'approvisionnent en le produit de r�f�rence 12
-- Avec une jointure
SELECT m.nom_mag
FROM magasin m
JOIN provenance p ON m.ref_mag = p.ref_mag
WHERE p.ref_prod = 12;

-- Avec une sous-requ�te
SELECT nom_mag
FROM magasin
WHERE ref_mag IN (SELECT ref_mag FROM provenance WHERE ref_prod = 1);

-- 15. Les noms des magasins qui ne s'approvisionnent pas en le produit de r�f�rence 12 (avec une sous-requ�te)
SELECT nom_mag
FROM magasin
WHERE ref_mag NOT IN (SELECT ref_mag FROM provenance WHERE ref_prod = 12);

-- 16. Les noms des magasins qui s'approvisionnent en produit rouge (avec des sous-requ�tes)
SELECT nom_mag
FROM magasin
WHERE ref_mag IN (SELECT ref_mag FROM provenance JOIN produit ON provenance.ref_prod = produit.ref_prod WHERE couleur = 'rouge');

-- 17. Les noms des magasins qui ne s'approvisionnent pas en enfer (nom de 2 usines) (avec des sous-requ�tes)
-- Note: Ici on consid�re deux usines d'approvisionment en 'enfer' (enfer1, enfer2)
SELECT nom_mag
FROM magasin
WHERE ref_mag NOT IN (
    SELECT ref_mag 
    FROM provenance 
    WHERE ref_usine IN (
        SELECT ref_usine 
        FROM usine 
        WHERE nom_usine IN ('enfer1', 'enfer2')
    )
);
