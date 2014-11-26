class icehouse::roles::swift_node {

  anchor { 'icehouse::profiles::swift::node': }
  Class { require => Anchor['icehouse::profiles::swift::node'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  $swift_disks = hiera('openstack::swift::disks')

  package { 'xfsprogs':
    ensure => latest,
  }

  file { '/srv/node':
    ensure => directory,
    owner  => 'swift',
    group  => 'swift',
    mode   => '0644',
  }

  cubbystack::functions::create_swift_device { $swift_disks:
    swift_zone => $::swift_zone,
    ip         => $ip,
    require    => [File['/srv/node'], Package['xfsprogs']],
  }

  class { 'cubbystack::repo':
    release => 'icehouse',
  } ->
  class { 'icehouse::profiles::common::users': }
  class { 'cubbystack::swift':
    settings => hiera('openstack::swift::settings'),
    require  => Class['icehouse::profiles::common::users'],
  }
  class { 'icehouse::profiles::swift::rsync':
    require  => Class['icehouse::profiles::common::users'],
  }
  class { 'icehouse::profiles::swift::account':
    require  => Class['icehouse::profiles::common::users'],
  }
  class { 'icehouse::profiles::swift::container':
    require  => Class['icehouse::profiles::common::users'],
  }
  class { 'icehouse::profiles::swift::object':
    require  => Class['icehouse::profiles::common::users'],
  }

}
