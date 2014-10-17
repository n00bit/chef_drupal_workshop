name "webserver"
description "Web server developer configuration"
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[mysql::server]",
  "recipe[nginx]",
  "recipe[php]",
  "recipe[php-fpm]",
  "recipe[postgresql::server]",
  "recipe[postgresql::client]",
  "recipe[phpmyadmin]",
  "recipe[phppgadmin]",
  "recipe[phing]",
  "recipe[composer]",
  "recipe[drupal]"
)

default_attributes(
  'mysql' => {
    :server_debian_password => "root",
    :server_repl_password => "root",
    :server_root_password => "root"
  },
  'postgresql' => {
    'password' => {
      'postgres' => 'root'
    }
  }
)