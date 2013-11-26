default['rfa-postfix']['main']['myhostname'] = 'mail.tire-attendant.jp' 
default['rfa-postfix']['main']['mydomain'] = 'tire-attendant.jp' 
default['rfa-postfix']['main']['myorigin'] = '$mydomain'
default['rfa-postfix']['main']['inet_interfaces'] = 'all'
default['rfa-postfix']['main']['inet_protocols'] = 'ipv4'
default['rfa-postfix']['main']['mydestination'] = '$myhostname, localhost.$mydomain, localhost, $mydomain' 
default['rfa-postfix']['main']['virtual_alias_maps'] = 'hash:/etc/postfix/virtual'
default['rfa-postfix']['main']['mynetworks'] = 'localhost'
default['rfa-postfix']['main']['home_mailbox'] = 'Maildir/'
default['rfa-postfix']['main']['smtp_sasl_auth_enable'] = 'yes'
default['rfa-postfix']['main']['smtpd_sasl_local_domain'] = node['rfa-postfix']['main']['mydomain']
default['rfa-postfix']['main']['smtpd_recipient_restriction'] = 'permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination'
default['rfa-postfix']['main']['smtpd_sasl_security_options'] = 'noanonymous,noplaintext'
default['rfa-postfix']['account']['userid01'] = 'info'
default['rfa-postfix']['account']['userpw01'] = 'info'
default['rfa-postfix']['account']['userfw01'] = 'okita@steady-inc.net'
default['rfa-postfix']['account']['userid02'] = 'admin'
default['rfa-postfix']['account']['userpw02'] = 'admin'
default['rfa-postfix']['account']['userfw02'] = 'okita@steady-inc.net'
