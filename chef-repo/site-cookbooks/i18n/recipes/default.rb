#
# Cookbook Name:: timezone
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/sysconfig/i18n" do
  source "i18n.erb"
end
