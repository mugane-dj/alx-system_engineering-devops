# Tune nginx to handle concurrent requests

exec { 'stop-nginx':
  command => 'service nginx stop',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'add-worker-rlimit':
  command => 'sed -i "s/15/100000" /etc/nginx/nginx.conf',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['stop-nginx']
}

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['add-worker-rlimit']
}
