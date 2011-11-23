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

  $packages = [ 'ruby', 'postgresql-server-dev-8.4', 'libmagick9-dev' ]
  package { $packages:
    ensure => present,
  }

  package { 'bundler':
    ensure   => present,
    require  => Package[$packages],
    provider => gem,
  }
}
