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

#br0設定
template "/etc/network/interfaces" do
  path "/etc/network/interfaces"
  source "interfaces.erb"
  mode 0644
  only_if { File.exists?("/etc/network/interfaces") }
end

# ufw設定ファイルの変更
execute "modify ufw" do
  user    'root'
  command "sed -i 's/^DEFAULT_FORWARD_POLICY="DROP"/DEFAULT_FORWARD_POLICY="ACCEPT"/g' /etc/default/ufw"
  only_if { File.exists?("/etc/default/ufw") }
end
