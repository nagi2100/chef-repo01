#
# Cookbook Name:: pgpool2
# Recipe:: default
# desc:: pgpoolのインストールを行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "postgresql"
include_recipe "pgpool2::source"

group "postgres" do
  gid 26
end

user "postgres" do
  shell    "/bin/bash"
  comment  "PostgreSQL Client"
  home     "/home/postgres"
  gid      "postgres"
  system   true
  uid      26
  supports :manage_home => true
end

bash "install pgpool via source" do
  user    "root"
  cwd     "#{node['pgpool2']['src_dir']}"
  not_if  "ls -d #{node['pgpool2']['src_dir']}/pgpool-II-#{node['pgpool2']['version']}"
 
  code <<-EOF
    tar zxf pgpool-II-#{node['pgpool2']['version']}.tar.gz
    cd pgpool-II-#{node['pgpool2']['version']}
    ./configure --prefix=#{node['pgpool2']['prefix_dir']} --sysconfdir=#{node['pgpool2']['conf_dir']}
    make
    make install
  EOF
end

bash "setup run directory" do
  user    "root"
  not_if  "ls -d #{node['pgpool2']['pid_dir']}"
  code <<-EOF
    mkdir -p #{node['pgpool2']['pid_dir']}
    chown postgres. #{node['pgpool2']['pid_dir']}
  EOF
end

template "/etc/init.d/pgpool" do
  user    "root"
  source  "pgpool_init_script.erb"
  mode    "0744"
end

service "pgpool" do
  action [:enable, :start]
end


