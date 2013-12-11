#
# Cookbook Name:: st-yum
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#pandorafms.repo配置
cookbook_file "pandorafms.repo" do
  path "/etc/yum.repos.d/pandorafms.repo"
  owner  "root"
  group  "root"
  mode 0644
  action :create
end

#リポジトリ情報更新
execute "yum makecache" do
  user 'root'
  command "yum makecache"
end
