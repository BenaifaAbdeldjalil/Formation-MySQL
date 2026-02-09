-- Nombre de commandes par client
SELECT 
    nom,
    prenom,
    (SELECT COUNT(*) 
     FROM commandes c 
     WHERE c.client_id = cl.id) AS nb_commandes
FROM clients cl;
