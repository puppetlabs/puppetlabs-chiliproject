class { 'chiliproject': }
class { 'chiliproject::repo': 
  staging_dir => '/home/puppet/chiliproject',
  repo_source => 'git://github.com/chiliproject/chiliproject.git', 
  git_revision => 'HEAD'
}
class { 'chiliproject::configuration': 
  path => '/home/puppet/chiliproject',
  db_adapter => mysql,
  db_name => chiliproject,
  db_host => localhost,
  db_user => chiliproject,
  db_password => puppet,
  db_encoding => utf8
}
class { 'chiliproject::deploy': }
