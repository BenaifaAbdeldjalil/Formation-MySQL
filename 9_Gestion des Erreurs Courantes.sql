-- ERREUR : Violation de contrainte
-- Si vous essayez : 
-- DELETE FROM clients WHERE id = 1;
-- Et qu'il y a des commandes pour ce client
-- MySQL refuse pour protéger l'intégrité

-- SOLUTION : Supprimer d'abord les commandes
DELETE FROM commandes WHERE client_id = 1;
DELETE FROM clients WHERE id = 1;
