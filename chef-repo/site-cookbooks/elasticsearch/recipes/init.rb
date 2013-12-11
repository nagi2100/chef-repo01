#
# Cookbook Name:: elastichsearch
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'elasticsearch'

package 'git'

execute "remove init script" do
  user 'root'
  command "rm /etc/init.d/elasticsearch"
end

execute "remove wrapper link" do
  user 'root'
  command "rm -r #{node.elasticsearch[:dir]}/elasticsearch/bin/service"
  only_if { File.exists?("#{node.elasticsearch[:dir]}/elasticsearch/bin/service") }
end

execute "remove service-wrapper dir" do
  user 'root'
  command "rm -r #{node.elasticsearch[:dir]}/elasticsearch/servicewrapper"
  only_if { File.exists?("#{node.elasticsearch[:dir]}/elasticsearch/servicewrapper") }
end

git "#{node.elasticsearch[:dir]}/elasticsearch/servicewrapper" do
  repository "git://github.com/elasticsearch/elasticsearch-servicewrapper.git"
  reference  "master"
  action     :sync
  user node.elasticsearch[:user] and group node.elasticsearch[:user] 
end

execute "create wrapper link" do
  user 'root'
  command "ln -s #{node.elasticsearch[:dir]}/elasticsearch/servicewrapper/service #{node.elasticsearch[:dir]}/elasticsearch/bin"
end

execute "install init script" do
  user 'root'
  command "bash #{node.elasticsearch[:dir]}/elasticsearch/bin/service/elasticsearch install"

  notifies :restart, 'service[elasticsearch]'
end

