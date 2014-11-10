class icehouse::profiles::swift::container {

  anchor { 'icehouse::profiles::swift::container': }
  Class { require => Anchor['icehouse::profiles::swift::container'] }

  rsync::server::module { 'container':
    path            => '/srv/node',
    lock_file       => "/var/lock/container.lock",
    uid             => 'swift',
    gid             => 'swift',
    max_connections => 25,
    read_only       => false,
  }

  $ring_server = hiera('openstack::swift_proxy')
  rsync::get { '/etc/swift/container.ring.gz':
    source => "rsync://${ring_server}/swift_server/container.ring.gz",
  }

  class { 'cubbystack::swift::container':
    settings => hiera('openstack::swift::container::settings'),
  }

}
