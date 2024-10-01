# config/deploy.rb

# Change these
server '103.173.63.62', roles: [:web, :app, :db], primary: true

set :application, 'livestock'
set :repo_url, 'git@github.com:rehan-ch/livestock.git' # Replace with your repo URL

set :user, 'livestock' # User to SSH into the server
set :puma_threads, [4, 16]
set :puma_workers, 0


# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/projects/#{fetch(:application)}"
set :shared_path, "#{fetch(:deploy_to)}/shared"
set :rbenv_type, :user # or :system, depending on your rbenv setup
set :rbenv_ruby, '3.2.3' # Replace with your desired Ruby version
# set :rbenv_path, '/home/livestock/.rbenv' # Path to rbenv installation
# Add rbenv to the path
# set :default_env, { path: "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH" }
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
# Puma configuration
set :puma_conf, "#{shared_path}/config/puma.rb" # Path to your Puma configuration
set :puma_daemonize, false

append :linked_files,  'config/credentials/production.key'
# Default branch is :main (change this if your branch is different)
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "systemctl  status puma.service"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  task :load_env do
    on roles(:app) do
      execute "source /home/livestock/projects/livestock/.rbenv-vars"
    end
  end

  before 'deploy:starting', 'deploy:load_env'
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

