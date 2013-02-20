require "bundler/capistrano"

set :domain, 'jo.jasonormand.com'
set :location, '192.81.216.66'
# role :web, '192.81.216.66' #nginx
# role :app, '192.81.216.66' #unicorn
# role :cache, '192.81.216.66' #varnish
set :application, 'jo'

set :scm, 'git'
set :repository,  'git@github.com:okor/JasonOrmand.com.git'
set :branch, 'master'
set :migrate_target, :current

set :user, 'deployer'
set :use_sudo, false  # may have to set this to true, can't tell yet

set :deploy_to, '/home/deployer/sites/jo'
set :deploy_via, :export



namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :except => { :no_release => true } do
    run "/etc/init.d/jo_unicorn restart"
  end
  task :clear_varnish do
  	sudo "varnishadm 'ban req.url ~ /'"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"



# /etc/init.d/jo_unicorn restart
# sudo varnishadm "ban req.url ~ /"