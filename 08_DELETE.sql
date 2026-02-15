-- 1. Supprimer une ligne
DELETE FROM clients WHERE id = 5;

-- 2. Supprimer avec condition
DELETE FROM commandes WHERE date_commande < '2024-01-01';

-- 3. Attention : toujours un WHERE !
-- ❌ DANGER : DELETE FROM clients;  -- Supprime TOUT

-- 4. TRUNCATE (vider table)
TRUNCATE TABLE logs_anciens;  -- Plus rapide, réinitialise auto_increment
