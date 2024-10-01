
# config/deploy/production.rb
set :production
set :branch, 'main' # Replace 'main' with the branch you want to deploy
server '103.173.63.62', user: 'livestock', roles: %w{app db web}
