#
# Cookbook Name:: lxc-ookt
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#関係するパッケージのインストール(ubuntuでcentosを動かす場合yumが必要)
%w{yum}.each do |package_name|
  package package_name do
    action :install
  end
end

#centosテンプレートの配置
cookbook_file "lxc-centos" do
  path "/usr/lib/lxc/templates/lxc-centos"
  owner  "root"
  group  "root"
  mode 0755
  action :create
end

#ubuntuテンプレートの配置
cookbook_file "lxc-ubuntu" do
  path "/usr/lib/lxc/templates/lxc-ubuntu"
  owner  "root"
  group  "root"
  mode 0755
  action :create
end

