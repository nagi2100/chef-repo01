#
# Cookbook Name:: iptables
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

iptables = "/etc/sysconfig/iptables"

node[:iptables][:add_lines].each do |line|
  # validate
  next if line[:before_pos].empty? or line[:add].empty?

  execute "Add setting line (#{line[:add]})" do
    command "sed -ie '/^#{line[:before_pos]}$/i #{line[:add]}' #{iptables}"
    not_if ( "grep -q -- \"#{line[:add]}\" #{iptables}" )
  end
end

execute "execute iptables-restore" do
  user 'root'
  command "iptables-restore < #{iptables}"
end
