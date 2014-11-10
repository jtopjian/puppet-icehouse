class icehouse::profiles::controller::horizon {

  anchor { 'icehouse::profiles::controller::horizon::begin': }
  anchor { 'icehouse::profiles::controller::horizon::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::horizon::begin'],
    before  => Anchor['icehouse::profiles::controller::horizon::end']
  }

  class { 'cubbystack::horizon':
    config_file => 'puppet:///modules/icehouse/horizon/local_settings.py'
  }

  file_line { 'horizon root url':
    path    => '/etc/apache2/conf-enabled/openstack-dashboard.conf',
    line    => 'WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi',
    match   => 'WSGIScriptAlias ',
    require => Class['cubbystack::horizon'],
  }

}
