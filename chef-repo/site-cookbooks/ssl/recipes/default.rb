#
# Cookbook Name:: ssl
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ssl_conf_dir = "#{node['ssl']['ssl_conf_dir']}"
ssl_script_dir = "#{node['ssl']['ssl_script_dir']}"
ssl_cert_dir = "#{node['ssl']['ssl_cert_dir']}"
ssl_intca_dir = "#{node['ssl']['ssl_intca_dir']}"
ssl_key_dir = "#{node['ssl']['ssl_key_dir']}"
ssl_script_file = "#{node['ssl']['ssl_script_file']}"
ssl_cert_file = "#{node['ssl']['ssl_domain']}#{node['ssl']['ssl_cert_file']}"
ssl_intca_file = "#{node['ssl']['ssl_intca_file']}"
ssl_key_file = "#{node['ssl']['ssl_domain']}#{node['ssl']['ssl_key_file']}"

#パッケージインストール
%w{mod_ssl}.each do |package_name|
  package package_name do
    action :install
  end
end

#ssl.conf配置
template "sslconf" do
  path "#{ssl_conf_dir}ssl.conf"
  source "sslconf.erb"
  mode 0644
end

directory "#{ssl_script_dir}" do
  recursive true
  mode 0755
  action :create
end

directory "#{ssl_cert_dir}" do
  recursive true
  mode 0755
  action :create
end

directory "#{ssl_intca_dir}" do
  recursive true
  mode 0755
  action :create
end

directory "#{ssl_key_dir}" do
  recursive true
  mode 0755
  action :create
end

#pp-filter配置
template "pp-filter" do
  path "#{ssl_script_dir}pp-filter"
  source "pp-filter.erb"
  mode 0755
end

cookbook_file "#{ssl_cert_dir}#{ssl_cert_file}" do
  source "#{ssl_cert_file}"
  mode 0600
end

cookbook_file "#{ssl_intca_dir}#{ssl_intca_file}" do
  source "#{ssl_intca_file}"
  mode 0600
end

cookbook_file "#{ssl_key_dir}#{ssl_key_file}" do
  source "#{ssl_key_file}"
  mode 0600
end

#service "httpd" do
#  action :restart
#end
