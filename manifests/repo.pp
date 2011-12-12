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
  $user = $chiliproject::data::user,
  $staging_dir = $chiliproject::data::staging_dir,
  $repo_source = $chiliproject::data::repo_source,
  $git_revision = $chiliproject::data::git_revision
) {
  file { $staging_dir:
    ensure => directory,
    owner  => $user,
    group  => $user,
    mode   => "0600",
  }

  vcsrepo { "chiliproject_repo":
    path     => $staging_dir,
    owner    => $user,
    group    => $user,
    ensure   => present,
    force    => true,
    source   => $repo_source,
    revision => $git_revision,
    provider => "git",
    require  => Class["chiliproject"],
  }

  # Needed because the rake db:migrate command is returning 1 instead of 0
  file { "$staging_dir/log/production.log":
    ensure  => present,
    mode    => "0666",
    require => Vcsrepo["chiliproject_repo"],
  }
}
