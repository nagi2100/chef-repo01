#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# 設定ファイルの変更
template "modify freshclam.conf" do
  path "/etc/freshclam.conf"
  source "freshclamconf.erb"
  mode 0644
end
