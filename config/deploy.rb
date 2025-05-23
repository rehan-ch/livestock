# config valid for current version and patch releases of Capistrano
lock "~> 3.19.1"

set :rbenv_ruby, '3.2.0'
set :user, 'livestock'

set :application, "livestock"
set :repo_url, "git@github.com:rehan-ch/livestock.git"
set :deploy_to, "/home/#{fetch(:user)}/project/#{fetch(:application)}"
append :linked_dirs, 'storage', "log"
# Issue with propshaft as asset pipwlinw
# See: https://github.com/capistrano/rails/issues/257
# Workaround
# set :assets_manifests, -> {
#   [release_path.join("public", fetch(:assets_prefix))]
# }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
