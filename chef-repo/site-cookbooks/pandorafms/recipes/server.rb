#
# Cookbook Name:: pandorafms
# Recipe:: server
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/etc/yum.repos.d/pandorafms.repo" do
  source "pandorafms.repo"
  owner "root"
  group "root"
  mode 0644
end

package "perl-Time-HiRes" do
  action :install
end

package "pandorafms_server" do
  action :install
end
