#
# Cookbook Name:: postgresql
# Recipe:: server
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# opscodeで公開されているレシピを実行する前にこのレシピを実行する

# いい実装ではないがgroup,userの作成はopscodeのレシピにあるものをコピペ
# そうしないとディレクトリの所有者を付与できない
group "postgres" do
  gid 26
end

user "postgres" do
  shell "/bin/bash"
  comment "PostgreSQL Server"
  home "/var/lib/pgsql"
  gid "postgres"
  system true
  uid 26
  supports :manage_home => false
end

unless node[:postgresql][:wal_archive_dir].nil?
  directory node[:postgresql][:wal_archive_dir] do
    owner     "postgres"
    group     "postgres"
    recursive true
    action    :create
  end
end

unless node[:postgresql][:config][:log_directory].nil?
  directory node[:postgresql][:config][:log_directory] do
    owner     "postgres"
    group     "postgres"
    recursive true
    action    :create
  end
end
