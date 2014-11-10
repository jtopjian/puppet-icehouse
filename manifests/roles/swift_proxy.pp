class icehouse::roles::swift_proxy {

  anchor { 'icehouse::roles::swift_proxy': }
  Class { require => Anchor['icehouse::roles::swift_proxy'] }

  class { 'icehouse::profiles::common::users': }
  class { 'icehouse::profiles::common::memcached': }
  class { 'cubbystack::swift':
    settings => hiera('openstack::swift::settings'),
    require  => Class['icehouse::profiles::common::users'],
  }
  class { 'icehouse::profiles::swift::rsync':
    require  => Class['icehouse::profiles::common::users']
  }
  class { 'icehouse::profiles::swift::rings':
    require  => Class['icehouse::profiles::common::users']
  }
  class { 'cubbystack::swift::proxy':
    settings => hiera('openstack::swift::proxy::settings'),
    require  => Class['icehouse::profiles::common::users']
  }

  # Extra packages
  $packages = ['swift-plugin-s3', 'python-keystone', 'python-keystoneclient']
  package { $packages:
    ensure => latest,
  }

  # sets up an rsync service that can be used to sync the ring DB
  rsync::server::module { 'swift_server':
    path            => '/etc/swift',
    lock_file       => '/var/lock/swift_server.lock',
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 5,
    read_only       => true,
  }

}
