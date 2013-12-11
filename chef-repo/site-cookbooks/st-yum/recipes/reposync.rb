#
# Cookbook Name:: st-yum
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#必要パッケージのインストール
%w{yum-utils createrepo}.each do |package_name|
  package package_name do
    action :install
  end
end

#centosテンプレートの配置
cookbook_file "yum-repo-sync.sh" do
  path "/usr/local/bin/yum-repo-sync.sh"
  owner  "root"
  group  "root"
  mode 0755
  action :create
end

#定期同期用cron設定
cron "yum-repo-sync" do
  user "root"
  minute "00"
  hour "4"
  weekday "2"
  command %Q!/usr/local/bin/yum-repo-sync.sh!
  action :create
end

#リポジトリの同期
#execute "execute yum-repo-sync" do
#  user 'root'
#  command "/usr/local/bin/yum-repo-sync.sh"
#end
