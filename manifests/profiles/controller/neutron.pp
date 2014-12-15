class icehouse::profiles::controller::neutron {

  anchor { 'icehouse::profiles::controller::neutron::begin': }
  anchor { 'icehouse::profiles::controller::neutron::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::neutron::begin'],
    before  => Anchor['icehouse::profiles::controller::neutron::end']
  }

  # Hiera
  $server_settings   = hiera('openstack::neutron::settings')
  $dhcp_settings     = hiera('openstack::neutron::dhcp::settings')
  $l3_settings       = hiera('openstack::neutron::l3::settings')
  $metadata_settings = hiera('openstack::neutron::metadata::settings')
  $ml2_settings      = hiera('openstack::neutron::plugins::ml2::settings')
  $local_ip          = hiera('network::internal::ip', $::ipaddress_eth0)

  # Determine the internal address for vxlan
  $vxlan = {
    'vxlan/local_ip' => $local_ip,
  }

  # merge the two settings
  $ml2_merged = merge($ml2_settings, $vxlan)

  class {'cubbystack::neutron':
      settings => $server_settings,
  }
  class { 'cubbystack::neutron::dhcp':
      settings => $dhcp_settings,
  }
  class { 'cubbystack::neutron::l3':
      settings => $l3_settings,
  }
  class { 'cubbystack::neutron::metadata':
      settings => $metadata_settings,
  }
  class { 'cubbystack::neutron::plugins::ml2':
      settings => $ml2_merged,
  }
  class { 'cubbystack::neutron::plugins::linuxbridge': }
  class { 'cubbystack::neutron::server': }

  file_line { '/etc/default/neutron-server NEUTRON_PLUGIN_CONFIG':
    path    => '/etc/default/neutron-server',
    line    => 'NEUTRON_PLUGIN_CONFIG="/etc/neutron/plugins/ml2/ml2_conf.ini"',
    match   => '^NEUTRON_PLUGIN_CONFIG',
    require => Class['cubbystack::neutron::plugins::ml2'],
  }

}
