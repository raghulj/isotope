require 'activerecord'

namespace :initial_dump do

	desc "Initial dump for admin and login and roles"
	task :dump_claim => :environment do
		#Rake::Task['initial_dump:create_db'].invoke
		#Rake::Task['initial_dump:create_tables'].invoke
		Rake::Task['initial_dump:dump_data'].invoke
	end

	desc "Create database tables"
	task :create_tables => :create_db do
		`rake db:schema:load`
	end

	desc "Create database"
  	task :create_db => :environment do
    		puts "creating database"
		Rake::Task['db:create'].invoke
		puts "database created successfully"
  	end

	desc " Create roles and users"
	task :dump_data => :create_tables do
		puts "Adding admin account to database"
		adm = User.create({:login =>'admin', :password => 'secretpassword', :password_confirmation => 'secretpassword', :email => 'raghulj@gmail.com'})
		adm.has_role('admin')
		demo = User.create({:login =>'demo', :password => 'demo', :password_confirmation => 'demo', :email => 'raghulj@gmail.com'})
		demo.has_role('viewer')
		user = User.create({:login =>'user', :password => 'user', :password_confirmation => 'user', :email => 'raghulj@gmail.com'})
		user.has_role('user')
		developer = User.create({:login =>'developer', :password => 'developer', :password_confirmation => 'developer', :email => 'raghulj@gmail.com'})
		developer.has_role('developer')

	end
end

