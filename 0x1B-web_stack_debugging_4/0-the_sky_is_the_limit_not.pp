# Tune nginx to handle concurrent requests

exec { 'add-workers':
  command => 'service nginx stop; sed -i "s/worker_processes 4/worker_processes 20/" /etc/nginx/nginx.conf',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'connections-config':
    command => 'sed -i "s/worker_connections 768/worker_connections 100/" /etc/nginx/nginx.conf',
    path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'multiaccept-config':
    command => 'sed -i "s/# multi_accept on/multi_accept on/" /etc/nginx/nginx.conf',
    path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}

exec { 'keepalive-config':
    command => 'sed -i "/^http {/a \        keepalive_requests 10000;" /etc/nginx/nginx.conf; service nginx restart',
    path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}
