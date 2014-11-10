class icehouse::profiles::common::memcached {

  anchor { 'icehouse::profiles::common::memcached::begin': }
  anchor { 'icehouse::profiles::common::memcached::end': }
  Class {
    require => Anchor['icehouse::profiles::common::memcached::begin'],
    before  => Anchor['icehouse::profiles::common::memcached::end'],
  }

  class { '::memcached':
    listen_ip => '127.0.0.1',
  }

  case $::operatingsystem {
    'Ubuntu': {
      package { 'python-memcache':
        ensure => latest,
      }
    }
  }

}
