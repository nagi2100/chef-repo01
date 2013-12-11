#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'kibana'

if node['kibana']['user'].empty?
  kibana_user = "#{node[webserver]['user']}"
else
  kibana_user = node['kibana']['user']
end

template "#{node['kibana']['installdir']}/current/config.js" do
  source "override_config.js.erb"
  owner kibana_user
  group kibana_user
  ## 実行権限がついていると403になるので外す
  mode "0644"
end

