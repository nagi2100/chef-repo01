#
# Cookbook Name:: unbound
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "unbound::default"

if node['unbound']['use_syslog'] == 'no'
  file "#{node['unbound']['logfile']}" do
    owner "unbound"
    group "unbound"
    mode "0755"
    action :create_if_missing
    notifies :restart, 'service[unbound]'
  end
end

