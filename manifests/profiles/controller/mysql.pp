class icehouse::profiles::controller::mysql {

  anchor { 'icehouse::profiles::controller::mysql::begin': }
  anchor { 'icehouse::profiles::controller::mysql::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::mysql::begin'],
    before  => Anchor['icehouse::profiles::controller::mysql::end']
  }

  $allowed_hosts = hiera('openstack::mysql::allowed_hosts')

  class { 'mysql::server':
    root_password           => hiera('openstack::mysql::root_password'),
    remove_default_accounts => true,
    restart                 => true,
    override_options        => {
      'mysqld' => {
        'bind_address' => '0.0.0.0',
      }
    },
  }

  include mysql::bindings
  include mysql::bindings::python

  cubbystack::functions::create_mysql_db { 'keystone':
    user          => 'keystone',
    password      => hiera('openstack::keystone::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'glance':
    user          => 'glance',
    password      => hiera('openstack::glance::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'cinder':
    user          => 'cinder',
    password      => hiera('openstack::cinder::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => hiera('openstack::nova::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'neutron':
    user          => 'neutron',
    password      => hiera('openstack::neutron::mysql::password'),
    allowed_hosts => $allowed_hosts,
  }

}
