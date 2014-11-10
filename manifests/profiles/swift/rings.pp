class icehouse::profiles::swift::rings {

  anchor { 'icehouse::profiles::swift::rings': }
  Class { require => Anchor['icehouse::profiles::swift::rings'] }

  # manage the rings
  Ring_object_device    <<| tag == $::location |>>
  Ring_container_device <<| tag == $::location |>>
  Ring_account_device   <<| tag == $::location |>>
  class { 'cubbystack::swift::rings':
    part_power     => hiera('openstack::swift::swift_part_power'),
    replicas       => hiera('openstack::swift::swift_replicas'),
    min_part_hours => hiera('openstack::swift::swift_min_part_hours'),
  }

}
