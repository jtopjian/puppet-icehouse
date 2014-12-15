class icehouse::profiles::controller::mysql {

  anchor { 'icehouse::profiles::controller::mysql::begin': }
  anchor { 'icehouse::profiles::controller::mysql::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::mysql::begin'],
    before  => Anchor['icehouse::profiles::controller::mysql::end']
  }

  # Hiera
  $allowed_hosts      = hiera('openstack::mysql::allowed_hosts')
  $keystone_password  = hiera('openstack::keystone::mysql::password')
  $glance_password    = hiera('openstack::glance::mysql::password')
  $nova_password      = hiera('openstack::nova::mysql::password')
  $cinder_password    = hiera('openstack::cinder::mysql::password')
  $neutron_password   = hiera('openstack::neutron::mysql::password')
  $heat_password      = hiera('openstack::heat::mysql::password')
  $trove_password     = hiera('openstack::trove::mysql::password')
  $stacktach_password = hiera('openstack::stacktach::mysql::password')

  include mysql::bindings
  include mysql::bindings::python

  cubbystack::functions::create_mysql_db { 'keystone':
    user          => 'keystone',
    password      => $keystone_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'glance':
    user          => 'glance',
    password      => $glance_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'cinder':
    user          => 'cinder',
    password      => $cinder_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'nova':
    user          => 'nova',
    password      => $nova_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'neutron':
    user          => 'neutron',
    password      => $neutron_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'heat':
    user          => 'heat',
    password      => $heat_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'trove':
    user          => 'trove',
    password      => $trove_password,
    allowed_hosts => $allowed_hosts,
  }

  cubbystack::functions::create_mysql_db { 'stacktach':
    user          => 'stacktach',
    password      => $stacktach_password,
    allowed_hosts => $allowed_hosts,
  }

}
