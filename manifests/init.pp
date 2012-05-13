# Class: chiliproject
#
#   Starting point for installing chiliproject.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class chiliproject {
  include chiliproject::data

  $packages = [ 'ruby', 'postgresql', 'postgresql-client', 'postgresql-server-dev-8.4', 'libmagick9-dev' ]
  package { $packages:
    ensure => present,
  }

  package { 'bundler':
    ensure   => present,
    require  => Package[$packages],
    provider => gem,
  }

  file { '/etc/postgresql/9.1/main/pg_hba.conf':
    ensure   => present,
    source   => "puppet:///modules/chiliproject/pg_hba.conf",
    require  => Package["postgresql"],
  }

  exec { 'db_passwd':
    command  => "psql --username postgres --command \"alter user postgres with password 'puppet'\"",
    path     => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    require  => [Package["postgresql-client"], File["/etc/postgresql/9.1/main/pg_hba.conf"]],
  }

  exec { 'db_init':
    command  => "psql --username postgres --command 'create database chiliproject'",
    path     => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    unless   => 'psql --username postgres --dbname chiliproject --command "\q"',
    require  => [Package["postgresql-client"], File["/etc/postgresql/9.1/main/pg_hba.conf"]],
  }
}
