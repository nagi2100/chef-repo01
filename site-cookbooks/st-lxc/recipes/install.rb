#
# Cookbook Name:: lxc-ookt
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#パッケージインストール
%w{debootstrap lxc lxctl}.each do |package_name|
  package package_name do
    action :install
  end
end
