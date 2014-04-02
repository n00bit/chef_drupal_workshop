include_recipe "drush"
include_recipe "php::module_gd"
include_recipe "php::module_mysql"

hw2_root = "/var/www/hw2"

directory "/var/www" do
  user "www-data"
  group "www-data"
  recursive true
end

resource_name = "vhost_drupal"

template "#{node['nginx']['dir']}/sites-available/#{resource_name}" do
  source "nginx-hw2.conf.erb"
  mode 0644
  variables(
    :server_name => "hw2.n00bit.no-ip.org",
    :root => hw2_root,
    :php_fpm_socket => '127.0.0.1:9001',
    :access_log => '/var/log/nginx/hw2.log'
  )
  notifies :reload, 'service[nginx]'
end

nginx_site resource_name do
  enable true
end


hw3_root = "/var/www/hw3"

template "#{node['nginx']['dir']}/sites-available/hw3" do
  source "nginx-hw3.conf.erb"
  mode 0644
  variables(
    :server_name => "hw3.n00bit.no-ip.org",
    :root => hw3_root,
    :access_log => '/var/log/nginx/hw3.log'
  )
  notifies :reload, 'service[nginx]'
end

nginx_site "hw3" do
  enable true
end

service "mysql"

execute "create_db" do
  command "mysql -u root -p#{node['mysql']['server_root_password']} -e 'CREATE DATABASE IF NOT EXISTS ololo;'"
end
