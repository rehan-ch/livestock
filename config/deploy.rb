# Change these
server '103.173.63.62', roles: [:web, :app, :db], primary: true

set :application, 'livestock'
set :repo_url, 'git@github.com:rehan-ch/livestock.git' # Replace with your repo URL

set :user, 'livestock'
set :puma_threads, [4, 16]
set :puma_workers, 0

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :stage, :production
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/projects/#{fetch(:application)}"
set :shared_path, "#{fetch(:deploy_to)}/shared"

set :rbenv_type, :user
set :rbenv_ruby, '3.2.0'
set :puma_daemonize, false
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{shared_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
set :ssh_options, { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true


# Symlink the production key and environment
append :linked_files, 'config/credentials/production.key'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system'

# Puma restart task
namespace :puma do
  desc 'Start Puma without daemonizing'
  task :start do
    on roles(:app) do
      within current_path do
        execute :bundle, 'exec puma -C', "#{shared_path}/puma.rb"
      end
    end
  end
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      invoke 'deploy'
      invoke 'puma:restart'
    end
  end

  desc 'Load environment variables'
  task :load_env do
    on roles(:app) do
      execute "source /home/livestock/projects/livestock/.rbenv-vars"
    end
  end

  # Hooks
  before 'deploy:starting', 'deploy:load_env'
  after 'deploy:publishing', 'puma:restart'
  after 'finishing', 'deploy:cleanup'
end
