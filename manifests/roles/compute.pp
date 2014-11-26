class icehouse::roles::compute {

  class { 'cubbystack::repo':
    release => 'icehouse',
  } ->
  class { 'icehouse::profiles::common::users': } ->
  class { 'icehouse::profiles::compute::nova': } ->
  class { 'icehouse::profiles::compute::neutron': }

}
