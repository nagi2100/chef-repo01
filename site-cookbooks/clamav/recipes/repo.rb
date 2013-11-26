#
# Cookbook Name:: clamav
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#htmlディレクトリ削除
#directory "/var/www/html" do
#  action :delete
#  only_if { File.exists?("/var/www/html") }
#end

#シンボリックリンク作成
link "/var/www/html" do
  to "/var/lib/clamav"
  link_type :symbolic
  action :create
end

#httpd.conf配置
template "httpdconf" do
  path "#{node['clamav']['httpd_conf_dir']}httpd.conf"
  source "httpdconf.erb"
  mode 0644
end

#サービス再起動
service "httpd" do
  action :restart
end

#定期スキャン用cron時間変更
cron "cron_clamscan" do
  user "root"
  minute "00"
  hour "2"
  weekday "2"
  command %Q!#{node['clamav']['script_path']}clam-full.sh!
  action :create
end

#freshclam初回実行
execute "freshclam_first_execute" do
    command "freshclam"
    action :run
end
