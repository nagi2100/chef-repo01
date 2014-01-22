default[:common][:hostname]           =  "BR-13-1-D00-XXX-01"
default[:common][:ipaddress]          =  "127.0.0.1"
default[:common][:domain]             =  "eigyo.co.jp"
default[:common][:networking]         =  "yes"
default[:common][:networking_ipv6]    =  "no"
default[:common][:fqdn]               =  "#{node[:common][:hostname]}.eigyo.co.jp"
default[:common][:nameservers]        =  ["8.8.4.4","8.8.8.8"]
