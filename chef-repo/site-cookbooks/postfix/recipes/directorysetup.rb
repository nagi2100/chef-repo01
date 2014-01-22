#
# Cookbook Name:: postfix
# Recipe:: server
# Desc:: Mialdirの作成を行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/root/Maildir" do
  owner     "root"
  group     "root"
  recursive true
  action    :create
end

directory "/etc/skel/Maildir" do
  owner     "root"
  group     "root"
  recursive true
  mode      0700
  action    :create
end
