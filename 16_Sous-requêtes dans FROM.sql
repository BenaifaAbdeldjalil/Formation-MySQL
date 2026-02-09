-- Statistiques par ville
SELECT 
    ville,
    moyenne_commandes
FROM (
    SELECT 
        c.ville,
        AVG(cmd_count.nb) AS moyenne_commandes
    FROM clients c
    JOIN (
        SELECT client_id, COUNT(*) as nb
        FROM commandes
        GROUP BY client_id
    ) cmd_count ON c.id = cmd_count.client_id
    GROUP BY c.ville
) AS stats_ville
WHERE moyenne_commandes > 1;
