class icehouse::profiles::swift::rsync {

  anchor { 'icehouse::profiles::swift::rsync': }
  Class { require => Anchor['icehouse::profiles::swift::rsync'] }

  # Determine the IP address
  $ip = hiera('network::internal::ip')

  class { 'rsync::server':
    use_xinetd => true,
    address    => $ip,
    use_chroot => 'no'
  }

}
