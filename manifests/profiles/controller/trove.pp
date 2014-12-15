class icehouse::profiles::controller::trove {

  anchor { 'icehouse::profiles::controller::trove::begin': }
  anchor { 'icehouse::profiles::controller::trove::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::trove::begin'],
    before  => Anchor['icehouse::profiles::controller::trove::end']
  }

  # Hiera
  $cloud_controller     = hiera('network::internal::ip')
  $rabbit_password      = hiera('openstack::rabbitmq::password')
  $nova_password        = hiera('openstack::nova::keystone::password')
  $settings             = hiera('openstack::trove::settings')
  $taskmanager_settings = hiera('openstack::trove::taskmanager::settings')
  $conductor_settings   = hiera('openstack::trove::conductor::settings')
  $api_paste_settings   = hiera('openstack::trove::api_paste::settings')

  class { 'cubbystack::trove':
    settings => $settings,
  }
  class { 'cubbystack::trove::api': }
  class { 'cubbystack::trove::taskmanager':
    settings => $taskmanager_settings,
  }
  class { 'cubbystack::trove::conductor':
    settings => $conductor_settings,
  }
  class { 'cubbystack::trove::api_paste':
    settings => $api_paste_settings,
  }
  class { 'cubbystack::trove::db_sync': }

  file { '/etc/init/trove-conductor.conf':
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0640',
    source => 'puppet:///modules/icehouse/profiles/trove/trove-conductor.conf',
    before => Class['cubbystack::trove::conductor'],
  }

  file { '/etc/trove/cloudinit/mysql.cloudinit':
    ensure  => present,
    owner   => 'trove',
    group   => 'trove',
    mode    => '0640',
    content => template('icehouse/profiles/trove/mysql.cloudinit.erb'),
    require => Class['cubbystack::trove'],
  }

  file { '/etc/trove/api-paste.ini':
    ensure  => present,
    owner   => 'trove',
    group   => 'trove',
    mode    => '0640',
    replace => false,
    source  => 'puppet:///modules/site/profiles/openstack/trove/api-paste.ini',
    require => Class['cubbystack::trove'],
    before  => Class['cubbystack::trove::api_paste'],
  }

}
