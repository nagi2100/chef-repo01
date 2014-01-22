#
# Cookbook Name:: common
# Recipe:: default
#
# Copyright 2013, Takafumi Asano <cariandrum22@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# STEADY managed user
user "john" do
  uid "2000"
  gid "wheel"
  comment "john"
  home "/home/john"
  shell "/bin/bash"
  password '$6$SteKrsIU3yIGpEZt$VP/PQizgMBQTl9k25PlY6e8p8.DVEmhi.nYLOAdTsJS3v1B8g8Ds/ffu1nmtTKYrP2NsC6sonO0QTpder4IOv.'
  supports :manage_home => true
end

directory '/home/john/.ssh' do
  owner "john"
  group "wheel"
  mode 0700
  action :create
end

cookbook_file "/home/john/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "john"
  group "wheel"
  mode 0600
  checksum "8af6cc1fa22edb3b3ead6980c8cb39e6124d60026a61c3c7e8137a1192483eaf"
end

#hosts
template "/etc/hosts" do
  source "etc_hosts.erb"
  owner "root"
  group "root"
  mode "0644"
end

#sysctl.conf
template "/etc/sysctl.conf" do
  source "etc_sysctl.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

#sudoers
template "/etc/sudoers" do
  source "etc_sudoers.erb"
  owner "root"
  group "root"
  mode "0440"
end

#networking
service "network" do
  supports :status => true, :restart => true
  action [ :enable , :start ]
end

template "/etc/sysconfig/network" do
  source "etc_sysconfig_network.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, 'service[network]'
end

#sshd
service "sshd" do
  supports :status => true, :restart => true
  action [ :enable , :start ]
end

template "/etc/ssh/sshd_config" do
  source "etc_ssh_sshd_config.erb"
  owner "root"
  group "root"
  mode "0600"
  notifies :restart, 'service[sshd]'
end

# package install
%w{yum-utils}.each do |package_name|
  package package_name do
    action :install
  end
end

# disable discard services
%w{ipv6tables iscsi iscsid mdmonitor netfs nfslock postfix rpcbind rpcgssd rpcidmapd}.each do |discard_service_name|
  service discard_service_name do
    action [:disable, :stop]
  end
end
