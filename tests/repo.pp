class { 'chiliproject': }
class { 'chiliproject::repo':
  staging_dir => '/home/puppet/chiliproject',
  repo_source => 'git://github.com/chiliproject/chiliproject.git', 
  git_revision => 'HEAD'
}
