#
# Cookbook Name:: user
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'users'

users_manage 'developer' do
  group_id 1000
  action [:remove, :create]
end
