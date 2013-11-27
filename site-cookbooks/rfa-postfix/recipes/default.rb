#
# Cookbook Name:: rfa-postfix
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

userid01 = "#{node['rfa-postfix']['account']['userid01']}"
userid02 = "#{node['rfa-postfix']['account']['userid02']}"
userpw01 = "#{node['rfa-postfix']['account']['userpw01']}"
domain = "#{node['rfa-postfix']['main']['mydomain']}"

%w{postfix mailx cyrus-sasl-md5}.each do |package_name|
  package package_name do
    action :install
  end
end

template "main.cf" do
  path "/etc/postfix/main.cf"
  source "maincf.erb"
  mode 0644
end

template "master.cf" do
  path "/etc/postfix/master.cf"
  source "mastercf.erb"
  mode 0644
end

template "virtual" do
  path "/etc/postfix/virtual"
  source "virtual.erb"
  mode 0644
end

template "smtpd.conf" do
  path "/etc/sasl2/smtpd.conf"
  source "smtpdconf.erb"
  mode 0644
end

directory "/etc/skel/Maildir" do
  recursive true
  mode 0700
  action :create
end

user "#{userid01}" do
  home "/home/#{userid01}"
  shell "/sbin/nologin"
  action :create
end

user "#{userid02}" do
  home "/home/#{userid02}"
  shell "/sbin/nologin"
  action :create
end

execute "saslpasswd2" do
    command "echo '#{userpw01}' | saslpasswd2 -u #{domain} #{userid01}"
    action :run
end

directory "/etc/sasldb2" do
  mode 0640
  group "postfix"
end

template "aliases" do
  path "/etc/aliases"
  source "aliases.erb"
  mode 0644
end

#template "aliases" do
#  path "/tmp/aliases.add"
#  source "aliases.erb"
#  mode 0644
#end

#execute "/etc/aliases" do
#    command "cat /tmp/aliases.add >> /etc/aliases"
#    action :run
#end

execute "newaliases" do
    command "newaliases"
    action :run
end

execute "postmap" do
    command "postmap /etc/postfix/virtual"
    action :run
end


service "postfix" do
  action :restart
end
