# Tune nginx to handle concurrent requests

exec { 'stop-nginx':
  command => 'service nginx stop',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'increase-worker-rlimit':
  command => 'sed -i "s/15/10000/" /etc/default/nginx',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['stop-nginx']
}

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['increase-worker-rlimit']
}
