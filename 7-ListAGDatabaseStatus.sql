USE master

--List AG databases status
SELECT g.name AS ag_name, g.is_distributed, r.replica_server_name, DB_NAME(drs.database_id) AS [db_name], drs.is_local, drs.is_primary_replica, 
drs.synchronization_state_desc, drs.synchronization_health_desc, drs.database_state_desc, drs.is_suspended, drs.suspend_reason_desc, 
drs.log_send_queue_size, drs.log_send_rate, drs.redo_queue_size, drs.redo_rate, drs.secondary_lag_seconds, 
drs.last_commit_time, drs.last_hardened_time, drs.last_sent_time, drs.last_received_time, drs.last_redone_time
FROM sys.availability_groups g
JOIN sys.availability_replicas r ON r.group_id = g.group_id
JOIN sys.dm_hadr_database_replica_states drs ON drs.group_id = r.group_id AND drs.replica_id = r.replica_id
