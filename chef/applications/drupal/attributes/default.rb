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
set['postgresql']['config']['listen_addresses'] = '0.0.0.0'

set['postgresql']['pg_hba'] = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'ident'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '0.0.0.0/0', :method => 'md5'},
]

