#
# Cookbook Name:: lxc-ookt
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
cookbook_file "lxc-centos" do
  path "/tmp/lxc-centos"
  action :create_if_missing
end
