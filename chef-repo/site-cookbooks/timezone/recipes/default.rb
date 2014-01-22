#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

file "/etc/localtime" do
  content IO.read "/usr/share/zoneinfo/#{node[:timezone][:area]}" 
end
