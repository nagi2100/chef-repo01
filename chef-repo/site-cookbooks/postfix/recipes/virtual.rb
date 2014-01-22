#
# Cookbook Name:: postfix
# Recipe:: server
# Desc:: virtualの設定を行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "postmap-service-reload" do
  command "postmap /etc/postfix/virtual"
  action :nothing
end

unless node['postfix']['virtual_conf'].nil?
  template node['postfix']['virtual_conf'] do
    source "virtual.erb"
    notifies :run,     "execute[postmap-service-reload]"
    notifies :reload,  "service[postfix]"
  end
end
