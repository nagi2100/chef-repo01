#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'td-agent'

template "/etc/td-agent/td-agent.conf" do
  source "br_server_td-agent.conf.erb"
  notifies :restart, 'service[td-agent]'
end

