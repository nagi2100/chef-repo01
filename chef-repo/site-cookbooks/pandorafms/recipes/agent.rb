#
# Cookbook Name:: pandorafms
# Recipe:: agent
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "pandorafms_agent_unix" do
  action :install
end

## plugins ##
cookbook_file "/etc/pandora/plugins/pandora_df_custom" do
  source "plugins/pandora_df_custom"
  owner "pandora"
  group "root"
  mode 0755
end
cookbook_file "/etc/pandora/plugins/memory_usage" do
  source "plugins/memory_usage"
  owner "pandora"
  group "root"
  mode 0755
end
cookbook_file "/etc/pandora/plugins/mysql_replication_status" do
  source "plugins/mysql_replication_status"
  owner "pandora"
  group "root"
  mode 0755
end
## plugins ##

template "/etc/pandora/pandora_agent.conf" do
  source "pandora_agent.conf.erb"
  notifies :restart, 'service[pandora_agent_daemon]'
  manage_symlink_source true
end

service "pandora_agent_daemon" do
  supports :status => true, :restart => true, :start => true
end
