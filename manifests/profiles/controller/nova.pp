class icehouse::profiles::controller::nova {

  anchor { 'icehouse::profiles::controller::nova::begin': }
  anchor { 'icehouse::profiles::controller::nova::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::nova::begin'],
    before  => Anchor['icehouse::profiles::controller::nova::end']
  }

  # Hiera
  $settings = hiera('openstack::nova::settings')

  class { 'cubbystack::nova':
    settings => $settings,
  }
  class { 'cubbystack::nova::api': }
  class { 'cubbystack::nova::cert': }
  class { 'cubbystack::nova::conductor': }
  class { 'cubbystack::nova::objectstore': }
  class { 'cubbystack::nova::scheduler': }
  class { 'cubbystack::nova::vncproxy': }
  class { 'cubbystack::nova::db_sync': }

  ## Generate an openrc file
  cubbystack::functions::create_openrc { '/root/openrc':
    keystone_host  => hiera('openstack::cloud_controller'),
    admin_password => hiera('openstack::keystone::admin::password'),
    admin_tenant   => 'admin',
    region         => hiera('openstack::region'),
  }

}
