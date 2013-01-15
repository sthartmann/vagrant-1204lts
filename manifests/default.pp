# Setting up Ubuntu 12.04 LTS Dev Virtual Machine

# installing updates and additional tools
class system {

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update && /usr/bin/touch /var/cache/apt/pkgcache.bin'
  }

  package { "vim":
  	ensure => present,
  	require => Exec['apt-get update'],
  }

  package { "curl":
  	ensure => present,
  	require => Exec['apt-get update'], 
  }

  package { "unzip":
  	ensure => present,
  	require => Exec['apt-get update'], 
  }

  package { "git":
  	ensure => present,
  	require => Exec['apt-get update'], 
  }

  package { "screen":
  	ensure => present,
  	require => Exec['apt-get update'], 
  }

}

# setting up apache2 as service
class apache {

  package { "apache2":
  	ensure => present,
  	require => Exec['apt-get update'],
  }
  
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  exec { "/usr/sbin/a2enmod rewrite":
  	unless => "/bin/readlink -e /etc/apache2/mods-enabled/rewrite.load",
    notify => Exec["force-reload-apache2"],
    require => Package["apache2"],
  }

  exec { "force-reload-apache2":
      command => "/etc/init.d/apache2 force-reload",
      refreshonly => true,
   }

}

# setting up php5 
class php {

  package { "php5":
  	ensure => latest,
  	require => Exec['apt-get update'],
  }
  
  package { "php5-cli":
  	ensure => latest,
    require => Exec['apt-get update'],
  }
  
  package { "php5-curl":
  	ensure => latest,
    require => Exec['apt-get update'],
  }

  package { "php5-mysqlnd":
  	ensure => latest,
    require => Exec['apt-get update'],
  }

  package { "php5-gd":
  	ensure => latest,
    require => Exec['apt-get update'],
  }

  package { "php5-xdebug":
  	ensure => latest,
    require => Exec['apt-get update'],
  }

  package { "libapache2-mod-php5":
  	ensure => latest,
    require => Exec['apt-get update'],
  }
  
}


# setting up tomcat as service
class tomcat {

  package { "tomcat6":
  	ensure => present,
  	require => Exec['apt-get update'],
  }

  package { "solr-tomcat":
  	ensure => present,
  	require => Package['tomcat6'],
  }  
  
  service { "tomcat6":
    ensure => running,
    require => Package["tomcat6"],
  }

}

# setting up mysql as a service
class mysql {

  package { "mysql-common":
  	ensure => present,
  	require => Exec['apt-get update'],
  }

  package { "mysql-server":
  	ensure => present,
	require => Exec['apt-get update'],
  }

}


include system
include apache
include php
include tomcat
include mysql