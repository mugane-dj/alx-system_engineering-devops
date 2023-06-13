# Tune nginx to handle concurrent requests

exec { 'stop-nginx':
  command => 'service nginx stop',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'add-workers':
  command => 'sed -i "s/worker_processes 4/worker_processes 20/" /etc/nginx/nginx.conf',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['stop-nginx']
}

exec { 'connections-config':
    command => 'sed -i "s/worker_connections 768/worker_connections 100/" /etc/nginx/nginx.conf',
    path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
    require => Exec['add-workers']
}

exec { 'keepalive-config':
    command => 'sed -i "/^http {/a \        keepalive_requests 10000;" /etc/nginx/nginx.conf',
    path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
    require => Exec['connections-config']
}

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin',
  require => Exec['keepalive-config']
}
