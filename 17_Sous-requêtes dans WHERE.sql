-- Clients qui ont passé commande
SELECT nom, prenom 
FROM clients 
WHERE id IN (
    SELECT DISTINCT client_id 
    FROM commandes
);

-- Produits plus chers que la moyenne
SELECT nom, prix 
FROM produits 
WHERE prix > (
    SELECT AVG(prix) 
    FROM produits
);
