class icehouse::roles::compute {

  class { 'cubbystack::repo': } ->
  class { 'icehouse::profiles::common::users': } ->
  class { 'icehouse::profiles::compute::nova': } ->
  class { 'icehouse::profiles::compute::neutron': }

}
