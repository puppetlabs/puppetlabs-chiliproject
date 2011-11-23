class chiliproject::data {
  $path         = '/var/www/html/chiliproject'
  $repo_source  = 'https://github.com/chiliproject/chiliproject.git'
  $staging_dir  = '/var/opt/lib/pe-puppet/staging'
  $git_revision = present
  $language     = 'en'
  $ignores      = [ '.git', 'database.yml', 'configuration.yml' ]
  $db_adapter   = 'postgresql'
  $db_name      = 'chiliproject'
  $db_host      = 'localhost'
  $db_port      = '5432'
  $db_user      = 'chiliproject'
  $db_password  = 'my_password'
  $db_encoding  = 'utf8'
}
