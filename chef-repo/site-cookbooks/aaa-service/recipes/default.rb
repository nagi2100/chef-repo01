#
# Cookbook Name:: aaa-service
# Recipe:: default
#
# Copyright 2013, Takafumi Asano <cariandrum22@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# package install
%w{ipa-server bind bind-dyndb-ldap freeradius-ldap}.each do |package_name|
  package package_name do
    action :install
  end
end

#iptables
service "iptables" do
  supports :status => true, :restart => true
  action [ :enable , :start ]
end

template "/etc/sysconfig/iptables" do
  source "etc_sysconfig_iptables.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, 'service[iptables]'
end

#FreeRADIUS
service "radiusd" do
  supports :status => true, :reload => true, :restart => true
  action [ :enable , :start ]
end

template "/etc/raddb/modules/ldap" do
  source "etc_raddb_modules_ldap.erb"
  owner "root"
  group "radiusd"
  mode "0640"
  notifies :reload, 'service[radiusd]'
end

template "/etc/raddb/clients.conf" do
  source "etc_raddb_clients.conf.erb"
  owner "root"
  group "radiusd"
  mode "0640"
  notifies :reload, 'service[radiusd]'
end

template "/etc/raddb/sites-available/default" do
  source "etc_raddb_sites-available_default.erb"
  owner "root"
  group "radiusd"
  mode "0640"
  notifies :reload, 'service[radiusd]'
end

# Deoloy FreeRadius Schema for 389 Directory 
service "dirsrv" do
  supports :status => true, :restart => true
  action [ :enable , :start ]
end

cookbook_file "/etc/dirsrv/slapd-EIGYO-CO-JP/schema/60freeradius.ldif" do
  source "60freeradius.ldif"
  mode 00440
  owner "dirsrv"
  group "dirsrv"
  checksum "f496eb550d213afc7a30c719043bef8eb899e6515ae295beb1cf5931eeac3e8b" 
  notifies :restart, 'service[dirsrv]'
end
