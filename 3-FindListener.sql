USE master

--List AG listeners with IPs
SELECT g.name AS ag_name, g.is_distributed, gl.dns_name, gl.port, glia.ip_address, glia.state_desc, glia.is_dhcp, 
glia.ip_subnet_mask, glia.network_subnet_ip, glia.network_subnet_prefix_length, glia.network_subnet_ipv4_mask
FROM sys.availability_groups g
JOIN sys.availability_group_listeners gl ON gl.group_id = g.group_id
JOIN sys.availability_group_listener_ip_addresses glia ON glia.listener_id = gl.listener_id
