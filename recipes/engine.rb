#
# Cookbook Name:: ovirt
# Recipe:: engine
# Author:: Jason Cannon
#

include_recipe "ovirt"

return unless node['ovirt']['supported_platforms'].include?(node['platform'])

answers_file = '/var/lib/ovirt-engine/setup/answers/answers-from-chef'

package 'ovirt-engine' do
  action :install
  notifies :create, "template[#{answers_file}]", :immediately
  notifies :run, "bash[engine-setup]", :immediately
end

template answers_file do
  source "answers.erb"
end
  
bash "engine-setup" do
  user 'root'
  path ['/usr/bin', '/bin', '/sbin', '/usr/sbin']
  code <<-EOH
    yes 'Yes' | engine-setup --config-append=#{answers_file}
  EOH
  notifies :restart, "service[ovirt-engine]"
  action :nothing
end

service 'ovirt-engine' do
  action [ :enable, :start ]
  supports :restart => true, :status => true
end
