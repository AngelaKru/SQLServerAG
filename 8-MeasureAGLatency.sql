USE master

--Measuring AG latency
SELECT g.name AS ag_name, g.is_distributed, r.replica_server_name, ars.role_desc, drs.is_primary_replica, DB_NAME(drs.database_id) AS [db_name], 
MAX(CASE WHEN drs.is_primary_replica = 1 THEN drs.last_commit_time END) OVER(PARTITION BY g.name, drs.database_id) AS primary_last_commit_time, 
CASE WHEN drs.is_primary_replica = 0 THEN drs.last_commit_time END AS secondary_last_commit_time, 
DATEDIFF(SECOND, drs.last_commit_time, MAX(CASE WHEN drs.is_primary_replica = 1 THEN drs.last_commit_time END) OVER(PARTITION BY g.name, drs.database_id)) AS secondary_lag_last_commit_time, 
drs.secondary_lag_seconds
FROM sys.availability_groups g
JOIN sys.availability_replicas r ON r.group_id = g.group_id
JOIN sys.dm_hadr_availability_replica_states ars ON ars.group_id = r.group_id AND ars.replica_id = r.replica_id
JOIN sys.dm_hadr_database_replica_states drs ON drs.group_id = r.group_id AND drs.replica_id = r.replica_id
ORDER BY ag_name, [db_name], drs.is_primary_replica DESC, r.replica_server_name
