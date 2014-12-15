class icehouse::profiles::swift::packages {

  $packages = ['swift-plugin-s3', 'python-keystone', 'python-keystoneclient']

  package { $packages:
    ensure => latest,
  }

}
