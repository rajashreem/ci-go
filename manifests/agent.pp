class ci-go::agent{

  $go_config = hiera_hash('ci_go')
  $version = $go_config['version']
  $build = $go_config['build']
  $go_server_ip = $go_config['server_ip']

  $go_agent_deb_package = "go-agent-${version}-${build}.deb"
  $go_agent_deb_package_url = "http://download01.thoughtworks.com/go/${version}/ga/${go_agent_deb_package}"
  $go_agent_package_download_path = '/var/tmp/go_agent.deb'

  Exec {
    path => "/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin"
  }

  include dependencies::java, dependencies::apache2

  exec { 'download_go_agent_package':
    command => "wget ${go_agent_deb_package_url} -O ${go_agent_package_download_path}",
    unless => "ls -la ${go_agent_package_download_path}",
    creates => $go_agent_download_path,
  }

  exec { 'install_go_agent':
    command => "dpkg -i ${$go_agent_package_download_path}",
    user => 'root',
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