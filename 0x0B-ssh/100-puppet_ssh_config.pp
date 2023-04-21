# Puppet manifest that configures ssh to disallow password authentication
class ssh {
    file {'/etc/ssh/ssh_config':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => "PasswordAuthentication no \n
                  IdentityFile ~/.ssh/school",
      notify  => Service['ssh'],
    }

    service { 'ssh':
      ensure => running,
      enable => true,
    }
}
