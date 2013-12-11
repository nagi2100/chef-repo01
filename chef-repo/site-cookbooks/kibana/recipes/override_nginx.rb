#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'kibana'

template "/etc/nginx/sites-available/kibana" do
  source "nginx_kibana.erb"
  variables(
    :es_server      => node['kibana']['es_server'],
    :es_port        => node['kibana']['es_port'],
    :server_name    => node['kibana']['webserver_hostname'],
    :server_aliases => node['kibana']['webserver_aliases'],
    :kibana_dir     => node['kibana']['installdir'],
    :listen_address => node['kibana']['webserver_listen'],
    :listen_port    => node['kibana']['webserver_port']
  )
  mode "0644"
end

