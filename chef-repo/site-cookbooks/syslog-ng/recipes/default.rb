#
# Cookbook Name:: syslog-ng
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::epel"

%w(syslog-ng eventlog syslog-ng-libdbi).each do |pkgname|
  package pkgname do
    action :install
  end
end

service "rsyslog" do
  action [:stop, :disable]
end

service "syslog-ng" do
  action [:start, :enable]
end

