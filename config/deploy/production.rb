set :application, 	"zhiyan"
set :domain, 		"li406-49.members.linode.com"
set :repository, 	"git@github.com:SummersAdvertising/zhiyan.git"
set :deploy_to,		"/var/spool/RoR-Projects/zhiyan"

role :app,		domain
role :web,	domain
role :db, 		domain,	:primary => true

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :user, "apps"
set :password, "1qaz2wsx"
set :group, "webs"

default_environment["PATH"] = "/opt/ree/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

namespace :deploy do
	desc "restart"
	task :restart do
		run "ln -s  #{shared_path}/uploads/ #{current_path}/public/uploads"
		
		run "cd #{current_path}; RAILS_ENV=production rake db:migrate; rake cache:clear"
	end
end

desc "Create database.yml and asset packages for production"
before("deploy:finalize_update") do
	db_config = "#{shared_path}/config/database.yml.production"
	#db_config = "#{db_config} #{release_path}/config/database.yml.production"
	run "cp #{db_config} #{release_path}/config/database.yml"
	
end

