set :application, "hueco"
set :user,        "root"
set :domain,      "#{user}@167.99.239.218"
set :deploy_to,   "/var/www/html/#{application}"
set :app_path,    "app"

#set :repository,  "git@github.com:dysan1376/hueco.git"
set :repository,  "https://dysan1376:3XL8Kr31@github.com/dysan1376/hueco.git"
set :scm,         :git
#set :deploy_via,  :copy
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `subversion`, `mercurial`, `perforce`, or `none`

set :model_manager, "doctrine"
# Or: `propel`

role :web,        domain                         # Your HTTP server, Apache/etc
role :app,        domain, :primary => true       # This may be the same as your `Web` server


set  :shared_files,      ["app/config/parameters.yml"]
set  :shared_childres,   [app_path + "/logs", web_path + "/uploads", "vendor"]


#set  :use_composer,    true
set  :composer_options, '--no-interaction --quiet --optimize-autoloader --no-progress'
#Workaround reciente para evitar que se quede estancado en install composer dependencies
#También es necesario comentar #set use_composer, true
#set  :update_vendors,  true
set  :copy_vendors,   true
#set :dump_assetic_assets, true

set  :keep_releases,  3

#ssh_options[:use_agent] = false
#ssh_options[:verbose] = :debug
#ssh_options[:auth_methods] = :publickey
#ssh_options[:keys] = %w(/Users/franklin/.ssh/id_ed25519)
#ssh_options[:forward_agent] = false

#default_run_options[:pty] = true

after "deploy:update", "deploy:mkdirs", "deploy:cleanup"

namespace :deploy  do
	desc "Permisos para escritura en app/cache"
	task :chmodcache do 
		run(" sudo chmod -R 777 #{current_path}/app/cache")
	end
end

namespace :deploy do
	desc "Crear app/cache, app/logs"
	task :mkdirs do
		run(" sudo chmod -R 777 #{release_path}/app/cache #{release_path}/app/logs")
	end
end




# Be more verbose by uncommenting the following line
#logger.level = Logger::MAX_LEVEL