# Apache returns 500 error due to bug in php module

exec { 'fix-wordpress':
  command => 'sed -i s/.phpp/.php/ var/www/html/wp-settings.php',
  path    => 'usr/local/bin:usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/bin'
}
