#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "vim" do
  action :install
end

namespace = 'users'
data_bag(namespace).each do |id|
  user = data_bag_item(namespace, id)
  template "/home/#{user['id']}/.vimrc" do
    source "vimrc.erb"
    owner  "#{user['id']}"
    group  "#{user['id']}"
  end
end
