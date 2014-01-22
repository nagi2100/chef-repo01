#
# Cookbook Name:: pgpool2
# Recipe:: source
# desc:: pgpoolのソース転送を行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "#{node['pgpool2']['src_dir']}/pgpool-II-#{node['pgpool2']['version']}.tar.gz" do
  user  'root'
  group 'root'
  mode  0644
end
