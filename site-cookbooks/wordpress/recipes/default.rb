#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
filename = "#{node['wordpress']['wp_tar_name']}"
install_dir = "#{node['wordpress']['install_dir']}"
document_root = "#{node['wordpress']['document_root']}"
remote_uri = "#{node['wordpress']['wp_tar_uri']}"
file_checksum = "#{node['wordpress']['wp_tar_sum']}"
httpd_conf_dir = "#{node['wordpress']['httpd_conf_dir']}"
htpasswd_file = "#{node['wordpress']['htpasswd_file']}"
htpasswd_id = "#{node['wordpress']['htpasswd_id']}"
htpasswd_pw = "#{node['wordpress']['htpasswd_pw']}"

#パッケージインストール
#%w{php-mysql}.each do |package_name|
#  package package_name do
#    action :install
#  end
#end

#WordPressダウンロード
remote_file "/tmp/#{filename}" do
  source "#{remote_uri}"
  checksum "#{file_checksum}"
end

#ドキュメントルート設定
directory "#{document_root}" do
  recursive true
  mode 0755
  owner "apache"
  group "apache"
end

#WordPress配置
script "install_wordpress" do
  interpreter "bash"
  user        "root"
  code <<-EOL
    install -d #{install_dir}
    tar zxvf /tmp/#{filename} -C #{install_dir}
  EOL
  not_if { File.exists?("#{document_root}") }
end

#httpd.conf配置
template "httpdconf" do
  path "#{httpd_conf_dir}httpd.conf"
  source "httpdconf.erb"
  mode 0644
  notifies :restart, "service[httpd]"
end

service "httpd"

#wordpressディレクトリpermission変更
directory "#{install_dir}" do
  recursive true
  mode 0755
  owner "apache"
  group "apache"
end

#htpasswd
include_recipe "htpasswd"
htpasswd "#{htpasswd_file}" do
  user "#{htpasswd_id}"
  password "#{htpasswd_pw}"
end
