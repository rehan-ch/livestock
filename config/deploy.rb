# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

# Application configuration
set :application, "livestock"
set :repo_url, "git@github.com:rehan-ch/livestock.git"
set :rbenv_ruby, '3.2.0'
set :user, 'livestock'

# Deploy configuration
set :deploy_to, "/home/#{fetch(:user)}/project/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :use_sudo, false

# Linked files and directories
append :linked_files, "config/database.yml", "config/master.key"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads", "storage"

# Asset pipeline configuration
set :assets_roles, [:web, :app]
set :assets_prefix, 'assets'
set :assets_manifests, -> {
  [release_path.join("public", fetch(:assets_prefix))]
}

# Passenger configuration
set :passenger_restart_with_touch, true

# RBENV configuration
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all

# Default value for keep_releases is 5
set :keep_releases, 5

# Logging
set :log_level, :info
set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# SSH Options
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  verify_host_key: :secure
}

# Deployment hooks
before 'deploy:starting', 'deploy:check'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'deploy:cleanup'

# Custom tasks
namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Check if we can access the server'
  task :check do
    on roles(:all) do |host|
      if test("[ -d #{deploy_to} ]")
        info "✓ #{host} - #{deploy_to} exists"
      else
        error "✗ #{host} - #{deploy_to} does not exist"
      end
    end
  end
end
