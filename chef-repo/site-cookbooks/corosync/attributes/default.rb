
# example
# [
#   {"ip" => "192.168.1.1", "hostname" => "cluster1"},
#   {"ip" => "192.168.1.2", "hostname" => "cluster2"},
# ]
default['corosync']['cluster_nodes'] = []
default['corosync']['cluster_nodes_segment'] = "0.0.0.0"
