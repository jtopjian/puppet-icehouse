class icehouse::profiles::compute::nova {

  anchor { 'icehouse::profiles::compute::nova::begin': }
  anchor { 'icehouse::profiles::compute::nova::end': }
  Class {
    require => Anchor['icehouse::profiles::compute::nova::begin'],
    before  => Anchor['icehouse::profiles::compute::nova::end'],
  }

  class { 'cubbystack::nova':
    settings => hiera('openstack::nova::settings'),
  }

  class { 'cubbystack::nova::compute': }

  case $::operatingsystem {
    'Ubuntu': {
      class { 'cubbystack::nova::compute::libvirt':
        libvirt_type => hiera('openstack::nova::compute::libvirt_type'),
      }
    }
  }

}
