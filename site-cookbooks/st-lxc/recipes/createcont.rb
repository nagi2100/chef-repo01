#
# Cookbook Name:: lxc-ookt
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

dist = "#{node['st-lxc']['dist']}"
contname = "#{node['st-lxc']['contname']}"

#lxc-veth配置
template "lxc-veth.conf" do
  path "/tmp/lxc-veth.conf"
  source "lxc-veth.conf.erb"
  mode 0644
end

#コンテナ作成
execute "lxc-create" do
  user 'root'
  command "lxc-create -t #{dist} -n #{contname} -f /tmp/lxc-veth.conf"
  not_if { File.exists?("/var/lib/lxc/#{contname}") }
end

#コンテナ起動
execute "lxc-start" do
  user 'root'
  command "lxc-start -n #{contname} -d"
  only_if "lxc-info -n #{contname} | grep 'STOPPED'" 
end
