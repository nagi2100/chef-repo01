#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "yum::epel"

#clamdインストール
%w{clamd}.each do |package_name|
  package package_name do
    action :install
  end
end

#定義ファイル更新cron設定
#cron "cron_freshclam" do
#  user "root"
#  minute "00"
#  hour "3"
#  weekday "2"
#  command %Q!/usr/bin/freshclam --quiet -l #{node['clamav']['log_path']}#{node['clamav']['freshclam_log_filename']}!
#  action :create
#end

# 設定ファイルの変更
execute "Modify clamd.conf" do
  user    'root'
  command "sed -i 's/^User clam/User root/g' /etc/clamd.conf"
  only_if { File.exists?("/etc/clamd.conf") }
end

#定期スキャン用スクリプト配置
template "clamscan_script" do
  path "#{node['clamav']['script_path']}clam-full.sh"
  source "clam-full.erb"
  mode 0755
end

#定期スキャン用cron設定
cron "cron_clamscan" do
  user "root"
  minute "00"
  hour "3"
  weekday "2"
  command %Q!#{node['clamav']['script_path']}clam-full.sh!
  action :create
end
execute "Remove update pattern daily jobs." do
  user 'root'
  command "rm /etc/cron.daily/freshclam"
  only_if { File.exists?("/etc/cron.daily/freshclam") } 
end


#隔離ディレクトリ作成
directory "#{node['clamav']['move_path']}" do
  recursive true
  mode 0755
  action :create
end

# scan除外ファイルの設置
template "#{node['clamav']['scan_exclude_config_path']}" do
  source "clamscan.exclude.erb"
  owner  "root"
  group  "root"
  mode   0644
end
