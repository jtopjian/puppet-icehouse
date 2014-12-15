class icehouse::profiles::controller::horizon {

  anchor { 'icehouse::profiles::controller::horizon::begin': }
  anchor { 'icehouse::profiles::controller::horizon::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::horizon::begin'],
    before  => Anchor['icehouse::profiles::controller::horizon::end']
  }

  # Hiera
  $config_file = hiera('openstack::horizon::config_file', 'puppet:///modules/icehouse/profiles/horizon/local_settings.py')

  class { 'cubbystack::horizon':
    config_file => $config_file,
  }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf-enabled/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
