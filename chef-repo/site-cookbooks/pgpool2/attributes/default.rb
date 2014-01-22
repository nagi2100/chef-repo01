
default['pgpool2']['src_dir']  = '/usr/local/src'
default['pgpool2']['version']  = '3.3.1'

default['pgpool2']['prefix_dir'] = '/usr/local'
default['pgpool2']['conf_dir']   = '/etc/pgpool2'
default['pgpool2']['pid_dir']    = '/var/run/pgpool2'

default['pgpool2']['user']       = 'pgpool'
# md5で暗号化したものを設定 default=[p@ssw0rd]
default['pgpool2']['password']   = 'f004031e832ec5e57f65206fd8cb80c2'


########## configuration pgpool.conf ##########
# choose replication, master-salve-Slony-I and master-slave-Streaming
default['pgpool2']['mode']              = 'replication'
default['pgpool2']['listen_addresses']  = '*'
default['pgpool2']['port']              = '9999'

# 想定される[ユーザ名:データベース名]のペアの種類の数だけ設定
# pgpool-II全体としては、num_init_children*max_pool 分だけ生成される
default['pgpool2']['num_init_children'] = '32'
default['pgpool2']['max_pool']          = '4'

# Postgresのバージョンによって設定を変更する
# 7.1以前	ABORT
# 7.2から8.2	ABORT; RESET ALL; SET SESSION AUTHORIZATION DEFAULT
# 8.3以降	ABORT; DISCARD ALL
default['pgpool2']['reset_query_list']  = 'ABORT; DISCARD ALL'

# e.g. default['pgpool2']['replication_nodes'] = [
#        {hostname: xxxxxx, port: 5432, weight: 1, data_directory: '/var/lib/pgsql/data', flag: 'ALLOW_TO_FAILOVER'},
#        {hostname: xxxxxx, port: 5432, weight: 1, data_directory: '/var/lib/pgsql/data', flag: 'ALLOW_TO_FAILOVER'},
#        {hostname: xxxxxx, port: 5432, weight: 1, data_directory: '/var/lib/pgsql/data', flag: 'ALLOW_TO_FAILOVER'},
#      ]
default['pgpool2']['replication_nodes'] = []


########## configuration pool_hba.conf ##########
# e.g. default['pgpool2']['hba_rules'] = [
#        {type: "host", database: "all", user: "all", cidr: "", method: "md5"},
#        {type: "host", database: "all", user: "all", cidr: "127.0.0.1/32 ", method: "md5"},
#      ]
default['pgpool2']['hba_rules']  = []
