# the chef-marketplace::config recipe will attempt to read in user supplied
# config from /etc/chef-marketplace/marketplace.rb and will override the default
# attributes in the node['chef-marketplace'] namespace.
#
# see libraries/marketplace.rb for full explanations of these attributes

default['chef-marketplace'].tap do |m|
  m['motd']['enabled'] = true
  m['support']['email'] = 'aws@chef.io'
  m['documentation']['url'] = 'https://docs.chef.io/aws_marketplace.html'
  m['role'] = 'server'
  m['license_count'] = 5
  m['platform'] = 'aws'
  m['user'] = 'ec2-user'
  m['publishing']['enabled'] = false
  m['api_ssl_port'] = 443
  m['reporting']['cron']['enabled'] = true
  m['reporting']['cron']['expression'] = '0 0 * * *'
  m['reporting']['cron']['year'] = 'date +%Y'
  m['reporting']['cron']['month'] = 'date +%m'
  m['analytics']['ssl_port'] = 8443
  m['analytics']['trimmer']['enabled'] = true
  m['analytics']['trimmer']['interval'] = 4
  m['analytics']['trimmer']['log_file'] = '/var/log/opscode-analytics/actions-trimmer.log'
  m['analytics']['trimmer']['max_db_size'] = 1
  m['compliance']['ssl_port'] = 443
end

default['openssh']['server'].tap do |server|
  server['protocol'] = 2
  server['syslog_facility'] = 'AUTHPRIV'
  server['permit_root_login'] = 'no'
  server['r_s_a_authentication'] = 'yes'
  server['pubkey_authentication'] = 'yes'
  server['password_authentication'] = 'no'
  server['authorized_keys_file'] = '.ssh/authorized_keys'
  server['challenge_response_authentication'] = 'no'
  server['g_s_s_a_p_i_authentication'] = 'yes'
  server['g_s_s_a_p_i_cleanup_credentials'] = 'yes'
  server['use_p_a_m'] = 'yes'
  server['use_d_n_s'] = 'no'
  server['Subsystem'] = 'sftp    /usr/libexec/openssh/sftp-server'
end
