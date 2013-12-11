#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

iptables = "/etc/sysconfig/iptables"

template iptables do
  source "iptables.erb"
  user 'root'
  mode "0600"
end

execute "execute iptables-restore" do
  user 'root'
  command "iptables-restore < #{iptables}"
end
