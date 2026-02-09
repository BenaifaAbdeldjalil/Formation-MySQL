-- 1. Tous les clients, même sans commande
SELECT 
    c.nom,
    c.prenom,
    COUNT(cmd.id) AS nb_commandes
FROM clients c
LEFT JOIN commandes cmd ON c.id = cmd.client_id
GROUP BY c.id;

-- 2. Produits jamais commandés
SELECT 
    p.nom,
    p.prix
FROM produits p
LEFT JOIN commandes c ON p.id = c.produit_id
WHERE c.id IS NULL;
