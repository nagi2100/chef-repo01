#
# Cookbook Name:: web-application
# Recipe:: default
#
# Copyright 2013, Takafumi Asano <cariandrum22@gmail.com>
#
# All rights reserved - Do Not Redistribute
#

# package install
%w{gcc make  zlib-devel httpd postgresql-pgpool-II mysql mod_ssl libuuid-devel php-mcrypt php-bcmath php-curl php-date php-dba php-dom php-exif php-gd php-imagick php-imap php-json php-libxml php-mbstring php-mysql php-mysqli php-ncurses php-openssl php-pcre php-pdo php-pdo_pgsql php-pdo_sqlite php-sqlite php-pgsql php-session php-snmp php-sockets php-standard php-xml php-xmlrpc php-zip php-zlib telnet}.each do |package_name|
  package package_name do
    action :install
  end
end

%w{Archive_Tar Console_Getopt Structures_Graph XML_Util uuid Net_Socket memcache}.each do |pear_package_name|
  php_pear pear_package_name do
    action :install
  end
end
