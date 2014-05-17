class go-ci::dependencies::java {
  package { 'openjdk-6-jre' :
    ensure => 'installed'
  }
}