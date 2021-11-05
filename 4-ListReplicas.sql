USE master

--List replicas
SELECT g.name AS ag_name, g.is_distributed, r.replica_server_name, r.endpoint_url, 
r.availability_mode_desc, r.failover_mode_desc, r.seeding_mode_desc, r.session_timeout, r.backup_priority, 
r.primary_role_allow_connections_desc, r.secondary_role_allow_connections_desc, r.read_only_routing_url
FROM sys.availability_groups g
JOIN sys.availability_replicas r ON r.group_id = g.group_id
ORDER BY ag_name, replica_server_name
