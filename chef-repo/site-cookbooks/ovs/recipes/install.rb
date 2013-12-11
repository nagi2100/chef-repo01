#
# Cookbook Name:: ovs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#execute "delete linux bridge 1" do
#  user 'root'
#    virsh net-destroy default
#  
#end
#execute "delete linux bridge 2" do
#  user 'root'
#    virsh net-autostart --disable default
#  
#end
execute "delete linux bridge 3" do
  user 'root'
  command "aptitude -y purge ebtables"
  
end

%w{gcc make build-essential fakeroot dkms procps debhelper autoconf automake libssl-dev pkg-config openssl python-all python-qt4 python-zopeinterface python-twisted-conch module-assistant}.each do |package_name|
  package package_name do
    action :install
  end
end

#

%w{/tmp/openvswitch-common_1.9.0-1_amd64.deb /tmp/openvswitch-switch_1.9.0-1_amd64.deb /tmp/openvswitch-datapath-dkms_1.9.0-1_all.deb /tmp/openvswitch-brcompat_1.9.0-1_amd64.deb}.each do |package_name|
  cookbook_file package_name do
    mode 0644 
  end
end

%w{/tmp/openvswitch-common_1.9.0-1_amd64.deb /tmp/openvswitch-switch_1.9.0-1_amd64.deb /tmp/openvswitch-datapath-dkms_1.9.0-1_all.deb /tmp/openvswitch-brcompat_1.9.0-1_amd64.deb}.each do |package_name|
  dpkg_package package_name do
    action :install
  end
end

#

execute "configure ovs1" do
  user 'root'
  command "modprobe -q -r bridge"
  only_if "lsmod | grep 'bridge'"
end

execute "configure ovs2" do
  user 'root'
  command "cp /lib/modules/3.8.0-29-generic/updates/dkms/brcompat.ko /lib/modules/3.8.0-29-generic/kernel/net/openvswitch/"
  only_if { File.exists?("/lib/modules/3.8.0-29-generic/updates/dkms/brcompat.ko") }
  not_if { File.exists?("/lib/modules/3.8.0-29-generic/kernel/net/openvswitch/brcompat.ko") }
end

execute "configure ovs3" do
  user 'root'
  command "modprobe -q -r openvswitch"
  only_if "lsmod | grep 'openvswitch'"
  not_if "lsmod | grep 'openvswitch' | grep 'brcompat'"
end

execute "configure ovs4" do
  user 'root'
  command "depmod -a"
end

execute "configure ovs5" do
  user 'root'
  command "modprobe -q openvswitch"
  not_if "lsmod | grep 'openvswitch'"
end

execute "configure ovs6" do
  user 'root'
  command "modprobe -q brcompat"
  not_if "lsmod | grep 'brcompat'"
end

execute "configure ovs7" do
  user 'root'
  command "update-initramfs -u"
end

template "openvswitch-switch" do
  path "/etc/default/openvswitch-switch"
  source "openvswitch-switch.erb"
  mode 0644
end

#OVS再起動
service "openvswitch-switch" do
  action :restart
end
