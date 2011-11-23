# Class: chiliproject::configuration
#
#   Configuration files for a chiliproject instance.
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class chiliproject::configuration(
  $path        = $chiliproject::data::path,
  $db_adapter  = $chiliproject::data::db_adapter,
  $db_name     = $chiliproject::data::db_name,
  $db_host     = $chiliproject::data::db_host,
  $db_port     = $chiliproject::data::db_port,
  $db_user     = $chiliproject::data::db_user,
  $db_password = $chiliproject::data::db_password,
  $db_encoding = $chiliproject::data::db_encoding
) {

  file { 'chiliproject_database_config':
    path    => "${path}/config/database.yml",
    source  => template('chiliproject/config/database.yml.erb'),
    require => Class['chiliproject::repo'],
    before  => Class['chiliproject::deploy'],
  }

  file { 'chiliproject_configuration':
    path    => "${path}/config/configuration.yml",
    source  => 'puppet:///modules/chiliproject/config/configuration.yml',
    require => Class['chiliproject::repo'],
    before  => Class['chiliproject::deploy'],
  }

}
