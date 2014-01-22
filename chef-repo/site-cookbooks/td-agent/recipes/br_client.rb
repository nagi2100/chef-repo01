#
# Cookbook Name:: td-agent
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'td-agent'

template "/etc/td-agent/td-agent.conf" do
  source "br_client_td-agent.conf.erb"
  notifies :restart, 'service[td-agent]'
end

## syslogのpermission変更
%w(messages secure).each do |file|
  execute "Add read permission. (/var/log/#{file})" do
    user    'root'
    command "chmod 644 /var/log/#{file}"
    only_if { File.exists?("/var/log/#{file}") }
  end
end

directory "/var/log/td-agent/pos" do
  owner     "td-agent"
  group     "td-agent"
  recursive true
  action    :create
end

## rsyslog.conf
[
  {name: 'FileCreateMode', value: "0644"}, 
  {name: 'DirCreateMode', value: "0755"}, 
  {name: 'umask', value: "0000"}, 
].each do |val|
  execute "Modify syslog.conf. add directive (#{val[:name]})" do
    user 'root'
    command "echo '$#{val[:name]} #{val[:value]}' >> /etc/rsyslog.conf"
    not_if ( "grep -q \"#{val[:name]}\" /etc/rsyslog.conf" )
	notifies :restart,  "service[rsyslog]"
  end
end

service "rsyslog" do
  supports :status => true, :restart => true, :start => true
end

