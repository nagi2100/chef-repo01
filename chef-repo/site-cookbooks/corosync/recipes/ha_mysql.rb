#
# Cookbook Name:: corosync
# Recipe:: ha_mysql
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'database::mysql'

mysql_connection_info = {:host     => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

# corosync用のユーザ
mysql_database_user node['corosync']['ha_mysql']['select_only_user'] do
  connection    mysql_connection_info
  password      node['corosync']['ha_mysql']['select_only_user_password']
  database_name "mysql"
  privileges    ['SELECT']
  action        [:create, :grant]
end

# replication用のユーザは２つ作成(localhost分と許可するhost分)
mysql_database_user node['corosync']['ha_mysql']['replication_user'] do
  connection    mysql_connection_info
  password      node['corosync']['ha_mysql']['replication_user_password']
  database_name "*"
  privileges    ['REPLICATION CLIENT', 'REPLICATION SLAVE', 'SUPER', 'PROCESS', 'RELOAD']
  action        [:create, :grant]
end
mysql_database_user node['corosync']['ha_mysql']['replication_user'] do
  connection    mysql_connection_info
  password      node['corosync']['ha_mysql']['replication_user_password']
  database_name "*"
  host          node['corosync']['ha_mysql']['replication_allow_host']
  privileges    ['REPLICATION CLIENT', 'REPLICATION SLAVE', 'SUPER', 'PROCESS', 'RELOAD']
  action        [:create, :grant]
end

template "/etc/corosync/resources.conf" do
  source "resources.conf.erb"
  user   "root"
  mode   "0600"
end

# corosyncから起動するので chkconfig off 
service "mysqld" do 
  action [:disable] 
end 
