-- 1. Commandes avec noms clients
SELECT 
    c.nom,
    c.prenom,
    cmd.date_commande,
    cmd.quantite
FROM commandes cmd
INNER JOIN clients c ON cmd.client_id = c.id;

-- 2. Commandes avec client ET produit
SELECT 
    cl.nom AS client,
    p.nom AS produit,
    c.quantite,
    p.prix,
    (p.prix * c.quantite) AS total
FROM commandes c
INNER JOIN clients cl ON c.client_id = cl.id
INNER JOIN produits p ON c.produit_id = p.id;
