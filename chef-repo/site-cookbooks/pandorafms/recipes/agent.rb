#
# Cookbook Name:: pandorafms
# Recipe:: agent
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

## plugins ##
cookbook_file "/etc/pandora/plugins/pandora_df_custom" do
  source "plugins/pandora_df_custom"
  owner "pandora"
  group "root"
  mode 0755
end

template "/etc/pandora/pandora_agent.conf" do
  source "pandora_agent.conf.erb"
  notifies :restart, 'service[pandora_agent_daemon]'
  manage_symlink_source true
end

service "pandora_agent_daemon" do
  supports :status => true, :restart => true, :start => true
end
