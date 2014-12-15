class icehouse::profiles::controller::glance {

  anchor { 'icehouse::profiles::controller::glance::begin': }
  anchor { 'icehouse::profiles::controller::glance::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::glance::begin'],
    before  => Anchor['icehouse::profiles::controller::glance::end'],
  }

  # Hiera
  $api_settings      = hiera('openstack::glance::api::settings')
  $registry_settings = hiera('openstack::glance::registry::settings')
  $cache_settings    = hiera('openstack::glance::cache::settings')

  class { 'cubbystack::glance': }
  class { 'cubbystack::glance::api':
    settings => $api_settings,
  }
  class { 'cubbystack::glance::registry':
    settings => $registry_settings,
  }
  class { 'cubbystack::glance::cache':
    settings => $cache_settings,
  }
  class { 'cubbystack::glance::db_sync': }

}
