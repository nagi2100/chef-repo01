#
# Cookbook Name:: lxc-ookt
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "lxc-centos" do
  path "/usr/lib/lxc/templates/lxc-centos"
  owner  "root"
  group  "root"
  mode 0755
  action :create_if_missing
end
