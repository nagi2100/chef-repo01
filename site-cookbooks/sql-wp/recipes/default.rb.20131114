#
# Cookbook Name:: sql-wp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
password = "#{node['mysql']['server_root_password']}"

template "sql-for-wordpress" do
  path "/tmp/wordpress.sql"
  source "wordpress.sql.erb"
  mode 0644
end

execute "mysql-create-user" do
    command "mysql -u root -p#{password} < /tmp/wordpress.sql"
    action :run
end
