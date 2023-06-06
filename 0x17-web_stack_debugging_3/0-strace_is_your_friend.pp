# Apache returns 500 error due to bug in php module

exec { 'Fix wp-settings.php':
  command => '/bin/sed -i s/.phpp/.php/ var/www/html/wp-settings.php',
  path    => 'usr/local/bin:usr/bin'
}
