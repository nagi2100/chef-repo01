#
# Cookbook Name:: console-logging
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#ログディレクトリ作成
directory "#{node['console-logging']['logdir']}" do
  recursive true
  mode 0755
  action :create
end

#/etc/profile配置
template "/etc/profile" do
  path "/etc/profile"
  source "profile.erb"
  mode 0644
end
