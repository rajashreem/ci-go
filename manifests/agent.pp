class ci-go::agent($version = '14.1.0', $build = '18882', $go_server_ip = '127.0.0.1'){

  $go_agent_deb_package = "go-agent-${version}-${build}.deb"
  $go_agent_deb_package_url = "http://download01.thoughtworks.com/go/${version}/ga/${go_agent_deb_package}"
  $go_agent_package_download_path = '/var/tmp/go_agent.deb'

  Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
  }

  include dependencies::java, dependencies::apache2

  exec { 'download_go_agent_package':
    command => "wget ${go_agent_deb_package_url} -O ${go_agent_package_download_path}",
    creates => $go_agent_download_path,
  }

  exec { 'install_go_agent':
    command => "dpkg -i ${$go_agent_package_download_path}",
    require => [Exec['download_go_agent_package'], Class['dependencies::java']]
  }

  file { 'agent_configuration':
    path => '/etc/default/go-agent',
    content => template('ci-go/go_agent_configuration.erb'),
    require => Exec['install_go_agent'],
    notify => Service['go-agent']
  }

  service { 'go-agent':
    ensure => running,
    require => Exec['install_go_agent']
  }
}