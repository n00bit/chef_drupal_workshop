set['php-fpm']['pools'] = [
  {
    :name => "drupal",
    :listen => "127.0.0.1:9001",
    :user => "www-data",
    :group => "www-data",
  }
]

set['mysql']['bind_address'] = "0.0.0.0"
set['mysql']['root_network_acl'] = "%"
