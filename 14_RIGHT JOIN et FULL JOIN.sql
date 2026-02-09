-- RIGHT JOIN (rare) : toutes les commandes, même sans client
SELECT 
    c.nom,
    cmd.id
FROM commandes cmd
RIGHT JOIN clients c ON cmd.client_id = c.id;

-- FULL JOIN (simulé avec UNION)
SELECT * FROM clients c
LEFT JOIN commandes cmd ON c.id = cmd.client_id
UNION
SELECT * FROM clients c
RIGHT JOIN commandes cmd ON c.id = cmd.client_id;
