# Note that you will need to set up MySQL and RabbitMQ
# oustide of this module
class icehouse::roles::controller {

  class { 'icehouse::profiles::common::users': } ->
  class { 'icehouse::profiles::common::memcached': } ->
  class { 'icehouse::profiles::common::utils': } ->
  class { 'icehouse::profiles::controller::mysql': } ->
  class { 'icehouse::profiles::controller::rabbitmq': } ->
  class { 'icehouse::profiles::controller::keystone': } ->
  class { 'icehouse::profiles::controller::glance': } ->
  class { 'icehouse::profiles::controller::nova': } ->
  class { 'icehouse::profiles::controller::cinder': } ->
  class { 'icehouse::profiles::controller::neutron': } ->
  class { 'icehouse::profiles::controller::heat': } ->
  #class { 'icehouse::profiles::controller::trove': } ->
  class { 'icehouse::profiles::controller::horizon': }

}
