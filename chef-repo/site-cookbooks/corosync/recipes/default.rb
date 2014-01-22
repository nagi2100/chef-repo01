#
# Cookbook Name:: corosync
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_key "RPM-GPG-KEY-network_ha-clustering_Stable" do
  url    "http://download.opensuse.org/repositories/network:/ha-clustering:/Stable/CentOS_CentOS-6/repodata/repomd.xml.key"
  action :add
end

yum_repository "network_ha-clustering_Stable" do
  description "Stable High Availability/Clustering packages (CentOS_CentOS-6)"
  url         "http://download.opensuse.org/repositories/network:/ha-clustering:/Stable/CentOS_CentOS-6/"
  key         "RPM-GPG-KEY-network_ha-clustering_Stable"
  action      :add
end

%w(pacemaker corosync crmsh).each do |pkgname|
  package pkgname do
    action :install
  end
end

template "/etc/corosync/corosync.conf" do
  source "corosync.conf.erb"
  user   "root"
  mode   "0644"
end

service "corosync" do 
  action [:disable] 
end 

