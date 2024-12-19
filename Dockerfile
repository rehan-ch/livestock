## syntax = docker/dockerfile:1
#
## Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
#ARG RUBY_VERSION=3.2.3
#FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
#
## Rails app lives here
#WORKDIR /rails
#
## Set production environment
#ENV RAILS_ENV="production" \
#    BUNDLE_DEPLOYMENT="1" \
#    BUNDLE_PATH="/usr/local/bundle" \
#    BUNDLE_WITHOUT="development"
#
#
## Throw-away build stage to reduce size of final image
#FROM base as build
#
## Install packages needed to build gems
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y build-essential git libvips pkg-config
#
## Install application gems
#COPY Gemfile Gemfile.lock ./
#RUN bundle install && \
#    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#    bundle exec bootsnap precompile --gemfile
#
## Copy application code
#COPY . .
#
## Precompile bootsnap code for faster boot times
#RUN bundle exec bootsnap precompile app/ lib/
#
## Precompiling assets for production without requiring secret RAILS_MASTER_KEY
#RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
#
#
## Final stage for app image
#FROM base
#
## Install packages needed for deployment
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
#    rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
## Copy built artifacts: gems, application
#COPY --from=build /usr/local/bundle /usr/local/bundle
#COPY --from=build /rails /rails
#
## Run and own only the runtime files as a non-root user for security
#RUN useradd rails --create-home --shell /bin/bash && \
#    chown -R rails:rails db log storage tmp
#USER rails:rails
#
## Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
## Start the server by default, this can be overwritten at runtime
#EXPOSE 3000
#CMD ["./bin/rails", "server"]



# syntax = docker/dockerfile:1

# Define Ruby version
ARG RUBY_VERSION=3.2.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Set working directory
WORKDIR /rails

# Set environment variables
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test" \
    SECRET_KEY_BASE_DUMMY="1"

# Reduce image size by cleaning up unnecessary files
RUN apt-get update -qq && apt-get install --no-install-recommends -y curl libvips libsqlite3-0 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Build stage
FROM base as build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    git \
    libvips \
    pkg-config \
    libpq-dev \
    libsqlite3-dev

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems and clean up
RUN gem install bundler && \
    bundle install --jobs=4 --retry=3 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}/ruby/*/cache" "${BUNDLE_PATH}/ruby/*/bundler/gems/*/.git"

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompile assets
RUN ./bin/rails assets:precompile

# Final app image
FROM base

# Copy built artifacts
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Add non-root user and set permissions
RUN useradd -ms /bin/bash rails && \
    chown -R rails:rails db log storage tmp
USER rails

# Entrypoint script to prepare database
ENTRYPOINT ["./bin/docker-entrypoint"]

# Expose default Rails port
EXPOSE 3000

# Default command to start Rails server
CMD ["./bin/rails", "server"]
