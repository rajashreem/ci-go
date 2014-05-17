class ci-go::dependencies::java {
  package { 'openjdk-6-jre' :
    ensure => 'installed'
  }
}