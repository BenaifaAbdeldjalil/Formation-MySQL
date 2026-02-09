-- Assure qu'une valeur est unique
CREATE UNIQUE INDEX idx_email_unique ON clients(email);

-- Test
INSERT INTO clients (nom, prenom, email) 
VALUES ('Test', 'Test', 'jean.dupont@email.com');  -- ❌ Erreur : email existe déjà
