USE master

--Find cluster name, quorum, cluster members, cluster network details
SELECT * FROM sys.dm_hadr_cluster
SELECT * FROM sys.dm_hadr_cluster_members
SELECT * FROM sys.dm_hadr_cluster_networks
