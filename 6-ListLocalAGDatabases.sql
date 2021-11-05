USE master

--List local AG databases
SELECT g.name AS ag_name, g.is_distributed, dc.database_name
FROM sys.availability_groups g
JOIN sys.availability_databases_cluster dc ON dc.group_id = g.group_id
