
describe group('www-data') do
	it { should exist }
end

describe user('www-data') do
	it { should exist }
end

["mariadb"].each do | pckg |
	describe package(pckg) do
		it { should_not be_installed }
	end
end

['/etc/mysql/my.cnf', '/var/run/mysqld/mysqld.pid', "/var/www/drupal/web/index.php", "/usr/local/bin/drush"].each do |app_file |
	describe file(app_file) do
		it { should be_file }
	end
end

["/var/www/drupal/web", "/etc/apache2/conf-enabled", "/etc/apache2/sites-enabled"].each do | app_dir |
	describe directory(app_dir) do
		it {should exist}
	end
end

describe file('/etc/apache2/sites-enabled/vhosts.conf') do
	it { should be_file }
	its(:content) { should match "<VirtualHost \\*:80>" }
end

describe file('/etc/apache2/sites-enabled/vhosts.conf') do
	it { should be_file }
	its(:content) { should match 'DocumentRoot "/var/www/drupal/web"' }
end

["mysql-server", "php7.0-common", "php-mysql", "php7.0-gd", "php7.0-fpm", "apache2"].each do | pckg |
	describe package(pckg) do
		it { should be_installed }
	end
end

["mysql.service", "apache2.service", "php7.0-fpm"].each do | app_service |
	describe service(app_service) do
		it { should be_enabled }
		it { should be_running }
	end
end

[80, 3306].each do | app_port |
	describe port(app_port) do
		it { should be_listening }
	end
end