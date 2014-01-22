default['clamav']['log_path'] = '/var/log/clamav/'
default['clamav']['clamscan_log_filename'] = 'clamav_`date +%Y-%m-%d`.log'
default['clamav']['freshclam_log_filename'] = 'freshclam.log'
default['clamav']['move_path'] = '/var/log/clamav/virus'
default['clamav']['scan_exclude_config_path'] = '/etc/clamscan_exclude.conf'
default['clamav']['exclude_list'] = ['/sys','/proc','/dev','/var/log/clamav/virus'] 
default['clamav']['script_path'] = '/usr/local/bin/'
