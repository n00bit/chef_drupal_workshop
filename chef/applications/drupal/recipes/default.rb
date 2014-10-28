include_recipe "php::module_gd"
include_recipe "php::module_mysql"
include_recipe "composer"

root = "/var/www"

directory "/var/www" do
  user "www-data"
  group "www-data"
  recursive true
end

resource_name = "webdb"

template "#{node['nginx']['dir']}/sites-available/#{resource_name}" do
  source "nginx.conf.erb"
  mode 0644
  variables(
    :server_name => "webdb.dev",
    :root => root,
    :php_fpm_socket => '127.0.0.1:9001',
    :access_log => '/var/log/nginx/webdb.log',
    :error_log => '/var/log/nginx/webdb_error.log'
  )
  notifies :reload, 'service[nginx]'
end

nginx_site resource_name do
  enable true
end

execute "create database" do
  command "mysql -uroot -p#{node['mysql']['server_root_password']} -e \"CREATE DATABASE IF NOT EXISTS  webdb\""
end

service "mysql" do
  action :restart
end
