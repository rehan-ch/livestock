source "https://rubygems.org"

ruby "3.2.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 6.4'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
gem 'bootstrap-sass', '~> 3.4'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Authentication and Authorization
gem "devise", "~> 4.9"

# Database
gem 'pg', '~> 1.5', '>= 1.5.6'

# Utilities
gem 'geocoder'
gem 'kaminari'
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'carrierwave'
gem 'mini_magick'
gem 'faker'
gem "letter_opener"
gem "letter_opener_web"

# Development and Testing
group :development, :test do
  gem 'pry', '~> 0.14.2'
  gem "debug", platforms: %i[ mri windows ]
  gem 'factory_bot_rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Deployment
  gem 'capistrano', "~> 3.17", require: false
  gem 'capistrano-rails', "~> 1.6", ">= 1.6.2", require: false
  gem 'capistrano-passenger', "~> 0.2", ">= 0.2.1", require: false
  gem 'capistrano-rbenv', "~> 2.2", require: false
  gem 'ed25519', '>= 1.2', '< 2.0'
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
  gem 'sshkit', '~> 1.23'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
