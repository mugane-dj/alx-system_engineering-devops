# Puppet manifest that configures ssh to disallow password authentication
class ssh_config {
    file {'/etc/ssh/sshd_config':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0600',
      content => "PasswordAuthentication no \n
                  IdentityFile ~/.ssh/school",
      notify  => Service['sshd'],
    }

    service { 'sshd':
      ensure => running,
      enable => true,
    }
}
