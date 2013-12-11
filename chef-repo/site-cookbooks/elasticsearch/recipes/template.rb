#
# Cookbook Name:: elastichsearch
# Recipe:: template
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'elasticsearch'

directory "#{node.elasticsearch[:dir]}/elasticsearch/config/templates" do
  user node.elasticsearch[:user] and group node.elasticsearch[:user] 
  action :create
end

Dir::foreach("#{File.dirname(__FILE__)}/../templates/default/tpl") { |f|
  next unless File::ftype("#{File.dirname(__FILE__)}/../templates/default/tpl/#{f}") == "file"

  template "#{node.elasticsearch[:dir]}/elasticsearch/config/templates/#{f.gsub(/\.erb/, '')}" do
    source "tpl/#{f}"
    user node.elasticsearch[:user]
    group node.elasticsearch[:user] 
    mode "0644"
  end
}

log "restart elasticsearch daemon" do
  notifies :restart, 'service[elasticsearch]'
end

