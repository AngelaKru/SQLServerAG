USE master

--Find availability groups on this instance
SELECT name, is_distributed, dtc_support, cluster_type_desc, failure_condition_level, automated_backup_preference_desc 
FROM sys.availability_groups
