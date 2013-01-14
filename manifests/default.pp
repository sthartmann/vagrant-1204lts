# Basic Puppet Apache manifest

# installing updates and additional tools
class system {
	
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update && /usr/bin/touch /var/cache/apt/pkgcache.bin'
  }

  package { "vim":
  	ensure => present,
  }

  package { "curl":
  	ensure => present, 
  }

}

# setting up apache2 as service
class apache {

  package { "apache2":
  	ensure => present,
  }
  
  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

}

# setting up php5 
class php {

  package { "php5":
  	ensure => latest,
  }
  
  package { "php5-cli":
  	ensure => latest,
  }

  package { "libapache2-mod-php5":
  	ensure => latest,
  }
  
}


# setting up tomcat as service
class tomcat {

  package { "tomcat6":
  	ensure => present,
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
  }

  package { "mysql-server":
  	ensure => present,
  }

 # package { "mysql-client":
 # 	ensure => present,
 # }
  
  service { "mysql-server":
    ensure => running,
    require => Package["mysql-server"],
  }

}




include system
include apache
include php
include tomcat
include mysql