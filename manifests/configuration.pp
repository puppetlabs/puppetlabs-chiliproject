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
  $user        = $chiliproject::data::user,
  $path        = $chiliproject::data::path,
  $db_adapter  = $chiliproject::data::db_adapter,
  $db_name     = $chiliproject::data::db_name,
  $db_host     = $chiliproject::data::db_host,
  $db_port     = $chiliproject::data::db_port,
  $db_user     = $chiliproject::data::db_user,
  $db_password = $chiliproject::data::db_password,
  $db_encoding = $chiliproject::data::db_encoding,
  $db_socket   = $chiliproject::data::db_socket,
  $email_address = $chiliproject::data::email_address,
  $email_domain = $chiliproject::data::email_domain,
  $email_user_name = $chiliproject::data::email_user_name,
  $email_password = $chiliproject::data::email_password,
  $email_tls = $chiliproject::data::email_tls,
  $email_starttls = $chiliproject::data::email_starttls,
  $email_port = $chiliproject::data::email_port,
  $email_auth = $chiliproject::data::email_auth
) {

  file { 'chiliproject_database_config':
    path    => "$path/config/database.yml",
    owner   => $user,
    group   => $user,
    content => template('chiliproject/config/database.yml.erb'),
    require => Class['chiliproject::repo'],
    before  => Class['chiliproject::deploy'],
  }

  file { 'chiliproject_configuration':
    path    => "$path/config/configuration.yml",
    owner   => $user,
    group   => $user,
    content => template('chiliproject/config/configuration.yml.erb'),
    require => Class['chiliproject::repo'],
    before  => Class['chiliproject::deploy'],
  }

}
