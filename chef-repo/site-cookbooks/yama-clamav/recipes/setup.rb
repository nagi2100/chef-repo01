#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# cronの設定
execute "Setting cron schedule, update virus pattern" do
  user 'root'
  command "mv /etc/cron.daily/freshclam /etc/cron.weekly/"
  only_if { File.exists?("/etc/cron.daily/freshclam") } 
end

template "/etc/cron.weekly/virusscan" do
  source "virusscan.erb"
  owner "root"
  group "root"
  mode   0744
end

# scan除外ファイルの設置
template "#{node['clamav']['scan_exclude_config_path']}" do
  source "clamscan.exclude.erb"
  owner  "root"
  group  "root"
  mode   0644
end

