-- 1. Créer une vue pour les commandes détaillées
CREATE VIEW vue_commandes_detaillees AS
SELECT 
    c.nom AS client_nom,
    c.prenom AS client_prenom,
    p.nom AS produit_nom,
    p.prix,
    cmd.quantite,
    (p.prix * cmd.quantite) AS total,
    cmd.date_commande
FROM commandes cmd
JOIN clients c ON cmd.client_id = c.id
JOIN produits p ON cmd.produit_id = p.id;

-- 2. Utiliser la vue comme une table
SELECT * FROM vue_commandes_detaillees;
SELECT client_nom, SUM(total) FROM vue_commandes_detaillees GROUP BY client_nom;

-- 3. Voir les vues existantes
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- 4. Supprimer une vue
DROP VIEW IF EXISTS vue_commandes_detaillees;
