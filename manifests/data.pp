class chiliproject::data {
  $user            = 'puppet'
  $path            = '/var/www/html/chiliproject'
  $repo_source     = 'https://github.com/chiliproject/chiliproject.git'
  $staging_dir     = '/var/opt/lib/pe-puppet/staging'
  $git_revision    = present
  $language        = 'en'
  $ignores         = [ '.git', 'database.yml', 'configuration.yml' ]
  $db_adapter      = 'postgresql'
  $db_name         = 'chiliproject'
  $db_host         = 'localhost'
  $db_port         = '5432'
  $db_user         = 'chiliproject'
  $db_password     = 'my_password'
  $db_encoding     = 'utf8'
  $email_address   = 'smtp.googlemail.com'
  $email_domain    = 'smtp.googlemail.com'
  $email_user_name = 'example@gmail.com'
  $email_password  = 'test'
  $email_tls       = 'true'
  $email_starttls  = 'true'
  $email_port      = '587'
  $email_auth      = ':plain'
}
