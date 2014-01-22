# # Cookbook Name:: pgpool2
# Recipe:: config
# desc:: pgpoolのconfigの設置を行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "#{node['pgpool2']['conf_dir']}/pgpool.conf" do
  user    "root"
  source  "pgpool.conf-#{node['pgpool2']['mode'] }.erb"
  mode    "0644"
end

template "#{node['pgpool2']['conf_dir']}/pool_hba.conf" do
  user    "root"
  source  "pool_hba.conf.erb"
  mode    "0644"
end

template "#{node['pgpool2']['conf_dir']}/pcp.conf" do
  user    "root"
  source  "pcp.conf.erb"
  mode    "0644"
end

service "pgpool" do
  action [:restart]
end


