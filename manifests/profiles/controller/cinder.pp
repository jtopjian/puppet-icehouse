class icehouse::profiles::controller::cinder {

  anchor { 'icehouse::profiles::controller::cinder::begin': }
  anchor { 'icehouse::profiles::controller::cinder::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::cinder::begin'],
    before  => Anchor['icehouse::profiles::controller::cinder::end'],
  }

  # Hiera
  $settings = hiera('openstack::cinder::settings')

  class { 'cubbystack::cinder':
    settings => $settings,
  }
  class { 'cubbystack::cinder::api': }
  class { 'cubbystack::cinder::scheduler': }
  class { 'cubbystack::cinder::volume': }
  class { 'cubbystack::cinder::db_sync': }

}
