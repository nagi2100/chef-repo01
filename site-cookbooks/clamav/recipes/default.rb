#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#filename = "epel-release-6-8.noarch.rpm"
#file_checksum = "e5ed9ecf22d0c4279e92075a64c757ad2b38049bcf5c16c4f2b75d5f6860dc0d"

#cookbook_file "/tmp/#{filename}" do
#  source "#{filename}"
#  checksum "#{file_checksum}"
#end

#package "epel" do
#  action :install
#  provider Chef::Provider::Package::Rpm
#  source "/tmp/#{filename}"
#end

include_recipe 'yum::epel'

%w{clamd}.each do |package_name|
  package package_name do
    action :install
  end
end

cron "cron_freshclam" do
  user "root"
  minute "00"
  hour "3"
  weekday "2"
  command %Q!/usr/bin/freshclam --quiet -l /var/log/clamav/freshclam.log!
  action :create
end

#cron "freshclam" do
#  action node.tags.include?('freshclam') ? :create : :delete
#  minute "00"
#  hour "3"
#  weekday "2"
#  user "root"
#  command %Q{
#     /usr/bin/freshclam --quiet -l /var/log/clamav/freshclam.log
#  }
#end

template "clamscan_script" do
  path "/usr/local/bin/clam-full.sh"
  source "clam-full.erb"
  mode 0755
end

cron "cron_clamscan" do
  user "root"
  minute "00"
  hour "3"
  weekday "2"
  command %Q!/usr/local/bin/clam-full.sh!
  action :create
end

directory "/var/log/clamav/virus" do
  recursive true
  mode 0755
  action :create
end
