log 'Upgrading the Chef Marketplace add-on..'

include_recipe 'yum-centos::default'

chef_ingredient 'chef-marketplace' do
  action :upgrade
  notifies :run, "execute['chef-marketplace-ctl reconfigure']", :immediately
end

execute 'chef-marketplace-ctl reconfigure' do
  action :nothing
end

log 'Upgrade complete!'