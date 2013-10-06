#
# Cookbook Name:: ovirt
# Attributes:: default
# Author:: Jason Cannon
#

default['ovirt']['application_mode']       = 'both'		# both, virt, gluster
default['ovirt']['storage_type']           = 'nfs'		# nfs, fc, iscsi, posixfs
default['ovirt']['organization']           = 'localdomain'
default['ovirt']['nfs_config_enabled']     = true		# true, false
default['ovirt']['iso_domain_name']        = 'ISO_DOMAIN'
default['ovirt']['iso_domain_mount_point'] = '/var/lib/exports/iso'
default['ovirt']['admin_password']         = 'admin'
default['ovirt']['db_user']                = 'engine'
default['ovirt']['db_password']            = 'dbpassword'
default['ovirt']['db_host']                = 'localhost'
default['ovirt']['db_port']                = '5432'
default['ovirt']['ovirt_release_base_url'] = 'http://ovirt.org/releases'
default['ovirt']['supported_platforms']    = %w{ centos fedora redhat }
  
case node['platform']
  when "centos", "redhat"
    default['ovirt']['firewall_manager']   = 'iptables'
  when "fedora"
    default['ovirt']['firewall_manager']   = 'firewalld'
end

