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

# Ensure assets are precompiled
set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

# Asset compilation settings
set :assets_compile, true
set :assets_compile_path, -> { release_path.join('public', fetch(:assets_prefix)) }
set :assets_compile_roles, [:web, :app]

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
  verify_host_key: :always
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

  desc 'Setup log directory'
  task :setup_logs do
    on roles(:app) do
      within shared_path do
        execute :mkdir, '-p', 'log'
        execute :chmod, '755', 'log'
        execute :touch, 'log/production.log'
        execute :chmod, '644', 'log/production.log'
      end
    end
  end
end

namespace :deploy do
  namespace :assets do
    desc 'Precompile assets'
    task :precompile do
      on roles(:web) do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :bundle, 'exec', 'rake', 'assets:precompile'
          end
        end
      end
    end

    desc 'Clean assets'
    task :clean do
      on roles(:web) do
        within release_path do
          execute :rm, '-rf', release_path.join('public', fetch(:assets_prefix))
        end
      end
    end
  end
end

# Skip asset manifest backup
Rake::Task['deploy:assets:backup_manifest'].clear_actions
