USE master

--AG replica health
SELECT g.name AS ag_name, g.is_distributed, r.replica_server_name, ars.role_desc, ars.is_local, 
ars.operational_state_desc, ars.connected_state_desc, ars.recovery_health_desc, ars.synchronization_health_desc, 
ars.last_connect_error_number, ars.last_connect_error_description, ars.last_connect_error_timestamp
FROM sys.availability_groups g
JOIN sys.availability_replicas r ON r.group_id = g.group_id
JOIN sys.dm_hadr_availability_replica_states ars ON ars.group_id = r.group_id AND ars.replica_id = r.replica_id
