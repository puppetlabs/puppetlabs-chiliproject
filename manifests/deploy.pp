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
  $path = $chiliproject::data::path
) {

  exec { 'chiliproject_bundle_install':
    command     => 'bundle install --without=test mysql mysql2 sqlite openid',
    path        => '/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    cwd         => $path,
    refreshonly => true,
    subscribe   => Class['chiliproject::repo'],
  }

  exec { 'chiliproject_migrate':
    command     => 'bundle exec rake db:migrate',
    path        => '/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    refreshonly => true,
    subscribe   => Class['chiliproject::repo'],
    require     => Exec['chiliproject_bundle_install'],
  }

  exec { 'gen_session_store':
    command     => 'bundle exec rake generate_session_store',
    path        => '/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => 'RAILS_ENV=production',
    cwd         => $path,
    creates     => "${path}/config/initializers/session_store.rb",
    require     => [ Class['chiliproject::repo'], Exec['chiliproject_bundle_install'] ],
  }

  exec { 'default_data':
    command     => 'bundle exec rake redmine:load_default_data',
    path        => '/usr/bin:/bin:/opt/puppet/bin:/var/lib/gems/1.8/bin',
    environment => [ 'REDMINE_LANG=en', 'RAILS_ENV=production' ],
    cwd         => $path,
    require     => [ Class['chiliproject::repo'], Exec['chiliproject_migrate'] ],
  }

}
