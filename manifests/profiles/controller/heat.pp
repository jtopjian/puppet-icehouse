class icehouse::profiles::controller::heat {

  anchor { 'icehouse::profiles::controller::heat::begin': }
  anchor { 'icehouse::profiles::controller::heat::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::heat::begin'],
    before  => Anchor['icehouse::profiles::controller::heat::end']
  }

  # Hiera
  $settings = hiera('openstack::heat::settings')

  class { 'cubbystack::heat':
    settings => $settings,
  }
  class { 'cubbystack::heat::api': }
  class { 'cubbystack::heat::api_cfn': }
  class { 'cubbystack::heat::api_cloudwatch': }
  class { 'cubbystack::heat::engine': }
  class { 'cubbystack::heat::db_sync': }

}
