class ci-go::dependencies::apache2 {
  package { 'apache2' :
    ensure => 'installed'
  }

  service { 'apache2':
    ensure => running,
    require => Package['apache2']
  }
}