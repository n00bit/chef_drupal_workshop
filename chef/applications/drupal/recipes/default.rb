include_recipe "php::module_gd"
include_recipe "php::module_mysql"

package "php5-xdebug"

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

execute "create database for mysql" do
  command "mysql -uroot -p#{node['mysql']['server_root_password']} -e \"CREATE DATABASE IF NOT EXISTS  webdb\""
end

execute "create database for postgres" do
  user 'postgres'
  command "createdb webdb || true"
end


service "mysql" do
  action :restart
end


service 'php5-fpm' do
  service_name 'php5-fpm'
  supports     :status => true, :restart => true, :reload => true
  action       [:enable, :start]
end


template "/etc/php5/fpm/php.ini" do
	source node['php']['ini']['template']
	cookbook node['php']['ini']['cookbook']
	unless platform?('windows')
		owner 'root'
		group 'root'
		mode '0644'
	end
	variables(:directives => node['php']['directives'])
	notifies :reload, 'service[php5-fpm]'
end
