class icehouse::profiles::compute::neutron {

  anchor { 'icehouse::profiles::compute::neutron::begin': }
  anchor { 'icehouse::profiles::compute::neutron::end': }
  Class {
    require => Anchor['icehouse::profiles::compute::neutron::begin'],
    before  => Anchor['icehouse::profiles::compute::neutron::end'],
  }

  # Hiera
  $settings         = hiera('openstack::neutron::settings')
  $ml2_settings     = hiera('openstack::neutron::plugins::ml2::settings')
  $internal_address = hiera('network::internal::ip')

  # Determine the internal address for vxlan
  $vxlan = {
    'vxlan/local_ip' => $internal_address,
  }

  # merge the two settings
  $ml2_merged = merge($ml2_settings, $vxlan)

  class { 'cubbystack::neutron':
    settings => $settings
  }
  class { 'cubbystack::neutron::plugins::ml2':
    settings => $ml2_merged
  }
  class { 'cubbystack::neutron::plugins::linuxbridge': }

}
