class icehouse::profiles::controller::rabbitmq {

  anchor { 'icehouse::profiles::controller::rabbitmq::begin': }
  anchor { 'icehouse::profiles::controller::rabbitmq::end': }
  Class {
    require => Anchor['icehouse::profiles::controller::rabbitmq::begin'],
    before  => Anchor['icehouse::profiles::controller::rabbitmq::end']
  }

  $userid   = hiera('openstack::rabbitmq::userid')
  $password = hiera('openstack::rabbitmq::password')

  class { '::rabbitmq::server':
    delete_guest_user => true,
  }

  rabbitmq_user { $userid:
    admin    => true,
    password => $password,
    require  => Class['::rabbitmq::server'],
  }

  rabbitmq_user_permissions { "${userid}@/":
    configure_permission => '.*',
    write_permission     => '.*',
    read_permission      => '.*',
  }

  rabbitmq_vhost { '/':
    require => Class['::rabbitmq::server'],
  }

}
