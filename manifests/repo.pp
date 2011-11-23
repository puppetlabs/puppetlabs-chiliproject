# Class: chiliproject::repo
#
#   Clones the chiliproject Git repo.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class chiliproject::repo(
  $staging_dir = $chiliproject::data::staging_dir,
  $repo_source = $chiliproject::data::repo_source,
  $git_revision = $chiliproject::data::git_revision
) {

  file { $staging_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }

  vcsrepo { 'chiliproject_repo':
    path     => $staging_dir,
    ensure   => $git_revision,
    source   => $repo_source,
    provider => 'git',
    require  => Class['chiliproject'],
  }

}
