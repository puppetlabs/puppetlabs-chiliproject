# Class: chiliproject::deploy
#
#   Deploys and migrates the chiliproject that is stored in Git repo.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class chiliproject::deploy(
  $path     = $chiliproject::data::path,
  $port     = 3000,
  $pid_file = "$path/tmp/pids/passenger.$port.pid",
  $user     = "puppet"
) {

  exec { 'chiliproject_bundle_install':
    command     => 'bundle install --without=test mysql mysql2 sqlite openid',
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    cwd         => $path,
    refreshonly => true,
    subscribe   => Class['chiliproject::repo'],
  }

  exec { 'chiliproject_migrate':
    command     => 'bundle exec rake db:migrate',
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    refreshonly => true,
    subscribe   => Class['chiliproject::repo'],
    require     => Exec['gen_session_store'],
  }

  exec { 'gen_session_store':
    command     => 'bundle exec rake generate_session_store',
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    creates     => "${path}/config/initializers/session_store.rb",
    require     => Exec['chiliproject_bundle_install']
  }

  exec { 'default_data':
    command     => 'bundle exec rake redmine:load_default_data',
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => ['REDMINE_LANG=en', 'RAILS_ENV=production'],
    cwd         => $path,
    require     => Exec['chiliproject_migrate']
  }
  
  file { "$path/vendor":
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/chiliproject/vendor' 
  }

  exec { 'plugins':
    command     => 'bundle exec rake db:migrate:plugins',
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    require     => File["$path/vendor"]
  }

  package { 'passenger':
    provider    => 'gem',
    name        => 'passenger',
    ensure      => 'latest'
  }

  exec { 'passenger':
    command     => "passenger start --port $port --pid-file $pid_file --user $user --daemonize",
    creates     => "$pid_file",
    path        => '/usr/local/bin:/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    require     => [File["$path/vendor"], Package['passenger']]
  }
}
