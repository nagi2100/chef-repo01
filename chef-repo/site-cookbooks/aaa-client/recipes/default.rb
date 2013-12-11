#
# Cookbook Name:: aaa-client
# Recipe:: default
#
# Copyright 2013, Takafumi Asano <cariandrum22@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# package install
%w{ipa-client libsss_sudo}.each do |package_name|
  package package_name do
    action :install
  end
end

#resolv.conf
template "/etc/resolv.conf" do
  source "etc_resolv.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

#nsswitch.conf
template "/etc/nsswitch.conf" do
  source "etc_nsswitch.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

#sssd
template "/etc/sssd/sssd.conf" do
  source "etc_sssd_sssd.conf.erb"
  owner "root"
  group "root"
  mode "0600"
end

#nslcd
#template "/etc/nslcd.conf" do
#  source "etc_nslcd.conf.erb"
#  owner "root"
#  group "root"
#  mode "0600"
#end

#pam
template "/etc/pam.d/system-auth-ac" do
  source "etc_pam.d_system-auth-ac.erb"
  owner "root"
  group "root"
  mode "0644"
end
