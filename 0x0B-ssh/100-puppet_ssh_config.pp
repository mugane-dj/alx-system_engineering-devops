# Puppet manifest that configures ssh to disallow password authentication
$config = file('/alx-system_engineering-devops/0x0B-ssh/2-ssh_config')
file {'/etc/ssh/ssh_config':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0600',
  content => $config
}
