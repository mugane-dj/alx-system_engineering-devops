# Puppet manifest that configures ssh to disallow password authentication
include stdlib

file_line { 'ssh_config_0':
  ensure => absent,
  path   => '/etc/ssh/ssh_config',
  line   => 'PasswordAuthentication no'
}

file_line { 'ssh_config_1':
  ensure => absent,
  path   => '/etc/ssh/ssh_config',
  line   => 'IdentityFile ~/.ssh/school'
}
