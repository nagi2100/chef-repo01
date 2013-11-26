#
# Cookbook Name:: rfa-mysql
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#data dir作成
mysql_data_dir = "#{node['rfa-mysql']['mysql_data_dir']}"
mysql_conf_dir = "#{node['rfa-mysql']['mysql_conf_dir']}"

#データディレクトリ作成
directory "#{mysql_data_dir}" do
  recursive true
  mode 0755
  action :create
end
