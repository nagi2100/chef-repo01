#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'yum::epel'

package "clamd" do
  action :install
end

package "mailx" do
  action :install
end

execute "Modify clamd.conf" do
  user 'root'
  command "sed -i 's/^User clam/User root/g' /etc/clamd.conf"
  only_if { File.exists?("/etc/clamd.conf") } 
end

service "clamd" do
  action [:start, :enable]
end

execute "Update virus pattern" do
  user 'root'
  command "freshclam"
end


