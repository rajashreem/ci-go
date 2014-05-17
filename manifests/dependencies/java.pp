class go_ci::dependencies::java {
  package { 'openjdk-6-jre' :
    ensure => 'installed'
  }
}