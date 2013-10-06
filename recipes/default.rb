#
# Cookbook Name:: ovirt
# Recipe:: default
# Author:: Jason Cannon
#

case node['platform']
  when 'centos', 'redhat'
    ovirt_os = 'el'
  when 'fedora'
    ovirt_os = 'fedora'
  else
    Chef::Log.error("#{node['platform']} operating system is not supported.")
    return
end

ovirt_rpm = "ovirt-release-#{ovirt_os}.noarch.rpm"

remote_file "#{Chef::Config[:file_cache_path]}/#{ovirt_rpm}" do
  source "#{node['ovirt']['ovirt_release_base_url']}/#{ovirt_rpm}"
  not_if "rpm -qa | grep 'ovirt-release'"
  notifies :install, "rpm_package[#{ovirt_rpm}]", :immediately
end

rpm_package ovirt_rpm do
  source "#{Chef::Config[:file_cache_path]}/#{ovirt_rpm}"
  only_if {::File.exists?("#{Chef::Config[:file_cache_path]}/#{ovirt_rpm}")}
  action :nothing
end
