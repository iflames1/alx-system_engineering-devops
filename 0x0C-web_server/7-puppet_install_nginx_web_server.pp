# Define a class to install and configure Nginx

class nginx_setup {

  # Ensure the Nginx package is installed
  package { 'nginx':
    ensure => installed,
  }

  # Ensure the Nginx service is running and enabled to start at boot
  service { 'nginx':
    ensure     => running,
    enable     => true,
    require    => Package['nginx'],
  }

  # Define the content for the Hello World page
  file { '/var/www/html/index.html':
    ensure  => file,
    content => 'Hello World!',
    require => Package['nginx'],
  }

  # Define the content for the Nginx configuration file
  file { '/etc/nginx/sites-available/default':
    ensure  => file,
    content => template('nginx_setup/nginx_default.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

}

# Apply the Nginx setup class
include nginx_setup
