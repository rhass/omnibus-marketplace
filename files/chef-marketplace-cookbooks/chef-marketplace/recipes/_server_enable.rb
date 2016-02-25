# Add chef-server-ctl marketplace-setup shim for backwards compatability
directory '/opt/opscode/embedded/service/omnibus-ctl' do
  owner 'root'
  group 'root'
  recursive true
  action :create
end

file '/opt/opscode/embedded/service/omnibus-ctl/marketplace_setup.rb' do
  owner 'root'
  group 'root'
  content <<'EOF'
add_command_under_category 'marketplace-setup', 'marketplace', 'Set up the Chef Server Marketplace Appliance', 2 do
  run_command("chef-marketplace-ctl setup #{ARGV[1..-1].join(' ')}")
end
EOF
  action :create
end

template '/etc/cron.d/reporting-partition-cleanup' do
  source 'reporting-partition-cleanup.erb'
  variables(
    expression: node['chef-marketplace']['reporting']['cron']['expression'],
    year: node['chef-marketplace']['reporting']['cron']['year'],
    month: node['chef-marketplace']['reporting']['cron']['month']
  )
  action reporting_partition_action
end

directory '/etc/opscode' do
  owner 'opscode'
  group 'opscode'
  action :create
end

template '/etc/opscode/chef-server.rb' do
  owner 'opscode'
  group 'opscode'
  action :create_if_missing
end

directory '/etc/chef-manage' do
  owner 'opscode'
  group 'opscode'
  action :create
end

file '/etc/chef-manage/manage.rb' do
  owner 'opscode'
  group 'opscode'
  # TODO: enable the marketplace sign_up after it's released
  #  content 'marketplace.sign_up.enabled = true'
  action :create
end
