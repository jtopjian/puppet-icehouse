class icehouse::profiles::controller::rabbitmq {

  anchor { 'icehouse::profiles::controller::rabbitmq::begin': }
  anchor { 'icehouse::profiles::controller::rabbitmq::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::rabbitmq::begin'],
    before  => Anchor['icehouse::profiles::controller::rabbitmq::end']
  }

  # Hiera
  $userid   = hiera('openstack::rabbitmq::userid', 'openstack')
  $password = hiera('openstack::rabbitmq::password')
  $vhost    = hiera('openstack::rabbitmq::vhost', '/')

  rabbitmq_user { $userid:
    admin    => true,
    password => $password,
    require  => Class['::rabbitmq::server'],
  }

  rabbitmq_user_permissions { "${userid}@${vhost}":
    configure_permission => '.*',
    write_permission     => '.*',
    read_permission      => '.*',
  }

  rabbitmq_vhost { $vhost:
    require => Class['::rabbitmq::server'],
  }

}
