server "192.168.11.176", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "jasonormand.com"
set :deploy_to, "/home/#{user}/sites/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
set :repository, "git@github.com:okor/jasonormand.com.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
