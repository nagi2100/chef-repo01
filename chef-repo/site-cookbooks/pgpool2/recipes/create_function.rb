#
# Cookbook Name:: pgpool2
# Recipe:: node
# desc:: pgpoolからアクセスされるサーバ側で必要なfunctionの作成を行います
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "pgpool2::source"

bash "create function pgpool_regclass and insert_lock" do
  user    "root"
  group   "root"
  cwd     "#{node['pgpool2']['src_dir']}"
  not_if  "ls -d #{node['pgpool2']['src_dir']}/pgpool-II-#{node['pgpool2']['version']}"

  code <<-EOF
    tar zxf pgpool-II-#{node['pgpool2']['version']}.tar.gz
    cd pgpool-II-#{node['pgpool2']['version']}/sql/
    sudo -u postgres psql -f insert_lock.sql template1
    cd pgpool-regclass
    make
    make install
    sudo -u postgres psql -f pgpool-regclass.sql template1
  EOF
end

