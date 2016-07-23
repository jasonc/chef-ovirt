name             'ovirt'
maintainer       'Jason Cannon'
maintainer_email 'jason@thisidig.com'
description      'Installs/Configures ovirt'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.4'

%w{ centos fedora redhat }.each do |os|
  supports os
end

source_url 'https://github.com/jasonc/chef-ovirt'
issues_url 'https://github.com/jasonc/chef-ovirt/issues'

recipe 'chef-ovirt', 'Installs the release RPM repository for oVirt'
recipe 'chef-ovirt::engine', 'Installs/Configures oVirt Engine'
recipe 'chef-ovirt::node', 'Installs VDSM on a standard OS install'
