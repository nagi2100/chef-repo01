
default['corosync']['ha_mysql']['config_path']               = "/etc/my.cnf"
default['corosync']['ha_mysql']['replication_user']          = 'replication'
default['corosync']['ha_mysql']['replication_user_password'] = 'zaq12wsx'
default['corosync']['ha_mysql']['replication_allow_host']    = 'localhost'
default['corosync']['ha_mysql']['select_only_user']          = 'corosync'
default['corosync']['ha_mysql']['select_only_user_password'] = 'zaq12wsx'
default['corosync']['ha_mysql']['default_master_hostname']   = nil

default['corosync']['ha_mysql']['master_vip']['ip']          = nil
default['corosync']['ha_mysql']['master_vip']['nic']         = nil
default['corosync']['ha_mysql']['master_vip']['netmask']     = nil
default['corosync']['ha_mysql']['master_vip']['broadcast']   = nil


