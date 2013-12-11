#
# Cookbook Name:: rvm
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w(chef-solo chef-client).each do |binary|
  link "/usr/bin/#{binary}" do
    action :delete
    only_if "test -L /usr/bin/#{binary}"
  end

  link "/usr/bin/#{binary}" do
    to "/usr/local/bin/#{binary}"
  end
end
