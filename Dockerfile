FROM ruby:2.6.3
MAINTAINER Santiago Ramos "sramos@sitiodistinto.net"

# Set the base directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN apt-get update -qq && \
    apt-get install -qq -y build-essential libpq-dev nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set base directory
RUN mkdir -p /railsapp
WORKDIR /railsapp

# Copy dependencies into the container
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5 --without development test

# Set the Rails environment to production
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Copy the main application into the container
COPY . ./
RUN chmod +x /railsapp/bin/*

# Precompile the Rails assets (with fake connection data)
RUN bundle exec rake RAILS_ENV=production SECRET_KEY_BASE=blahblahblah assets:clobber
RUN bundle exec rake RAILS_ENV=production SECRET_KEY_BASE=blahblahblah assets:precompile

# Start the application with Puma
ENTRYPOINT ["/railsapp/bin/entrypoint"]
CMD bundle exec puma -C config/puma.rb
