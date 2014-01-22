#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

template "/etc/nginx/conf.d/default.conf" do
  source "default.conf.erb"
  mode "0644"
end

