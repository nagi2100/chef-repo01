#
# Cookbook Name:: zlbpatch
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
template "zlb_init_script" do
  path "/etc/init.d/zenloadbalancer"
  source "zenloadbalancer.erb"
  mode 0755
end

template "zlb_static_routes" do
  path "/etc/network/if-up.d/static-routes"
  source "static-routes.erb"
  mode 0644
end

execute "zlb_sysctl" do
  user    'root'
  command "sed -i 's/#net.ipv4.ip_forward/net.ipv4.ip_forward/g' /etc/sysctl.conf"
  only_if { File.exists?("/etc/sysctl.conf") }
end

template "zlb_iptables_up_rules" do
  path "/etc/iptables.up.rules"
  source "iptables.up.rules.erb"
  mode 0644
end

template "iptables" do
  path "/etc/network/if-pre-up.d/iptables"
  source "iptables.erb"
  mode 0644
end
