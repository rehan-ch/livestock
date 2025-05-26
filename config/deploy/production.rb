# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}

set :production
set :branch, 'main' # Replace 'main' with the branch you want to deploy
server '103.173.63.62', user: 'livestock', roles: %w{app db web}

# Production-specific settings
set :rails_env, 'production'
set :deploy_to, "/home/#{fetch(:user)}/project/#{fetch(:application)}"

# Ensure proper permissions
set :file_permissions_paths, [
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'public/system',
  'public/uploads',
  'storage',
  'public/assets'
]

# SSH Options for production
set :ssh_options, {
  keys: %w(/home/livestock/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey),
  verify_host_key: :secure
}

# Asset compilation settings for production
set :assets_compile, true
set :assets_compile_path, -> { release_path.join('public', fetch(:assets_prefix)) }
set :assets_manifests, -> {
  [release_path.join("public", fetch(:assets_prefix))]
}

# Passenger configuration
set :passenger_restart_with_touch, true

# Keep fewer releases to save disk space
set :keep_releases, 5

# Add deployment hooks
before 'deploy:starting', 'deploy:check'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:restart', 'deploy:cleanup'

# Custom tasks for production
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

# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
