USE master

--AG failovers
SELECT XEData.value('(event/@timestamp)[1]', 'datetime2(3)') AS event_timestamp, 
XEData.value('(event/data[@name="availability_group_name"]/value)[1]', 'varchar(255)') AS availability_group_name, 
XEData.value('(event/data[@name="availability_replica_name"]/value)[1]', 'varchar(255)') AS availability_replica_name, 
XEData.value('(event/data[@name="previous_state"]/text)[1]', 'varchar(255)') AS previous_state, 
XEData.value('(event/data[@name="current_state"]/text)[1]', 'varchar(255)') AS current_state
FROM (
SELECT CAST(event_data AS XML) XEData
FROM sys.fn_xe_file_target_read_file((
SELECT CAST(target_data AS XML).value('(EventFileTarget/File/@name)[1]', 'nvarchar(4000)')
FROM sys.dm_xe_sessions s
JOIN sys.dm_xe_session_targets t ON s.address = t.event_session_address
WHERE s.name = N'AlwaysOn_health'
), NULL, NULL, NULL)
WHERE object_name = 'availability_replica_state_change'
) d
WHERE XEData.value('(event/data[@name="current_state"]/text)[1]', 'varchar(255)') IN ('PRIMARY_NORMAL', 'GLOBAL_PRIMARY', 'FORWARDER') --capture local AG and distributed AG
ORDER BY event_timestamp DESC
