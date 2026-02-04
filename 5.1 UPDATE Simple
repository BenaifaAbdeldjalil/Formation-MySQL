-- 1. Modifier une ligne
UPDATE clients SET ville = 'Lyon' WHERE id = 1;

-- 2. Modifier plusieurs colonnes
UPDATE clients 
SET ville = 'Marseille', email = 'nouveau@email.com'
WHERE nom = 'Bernard';

-- 3. Modification avec calcul
UPDATE produits SET prix = prix * 0.9 WHERE categorie = 'Électronique';

-- 4. Toujours vérifier avant !
SELECT * FROM clients WHERE id = 1;  -- Avant
UPDATE clients SET ville = 'Lyon' WHERE id = 1;
SELECT * FROM clients WHERE id = 1;  -- Après
