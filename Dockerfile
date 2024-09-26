# syntax = docker/dockerfile:1

# Taken from https://docs.docker.com/guides/language/ruby/containerize/ with changes

ARG RUBY_VERSION=3.3.5
FROM ruby:$RUBY_VERSION

# Install dependencies, cache them using BuildKit,
# see https://stackoverflow.com/questions/66808788/docker-can-you-cache-apt-get-package-installs
RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
    --mount=target=/var/cache/apt,type=cache,sharing=locked \
    apt-get update -qq && apt-get install -y \
    postgresql-client \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    build-essential

# I dont think we need this!
# # Install rbenv
# RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
#     echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
#     echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
#     git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
#     echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc

# # Install the specified Ruby version using rbenv
# ENV PATH="/root/.rbenv/bin:/root/.rbenv/shims:$PATH"
# RUN rbenv install 3.2.0 && rbenv global 3.2.0

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install Gems dependencies
RUN gem install bundler && bundle install

# Copy the application code
COPY . /app
# We do not need to mount it because of docker compose watch, i think,
# see https://docs.docker.com/guides/language/ruby/develop/#automatically-update-services

# Precompile assets (optional, if using Rails with assets)
RUN bundle exec rake assets:precompile

# Expose the port the app runs on
EXPOSE 3000

# Command to run the server
CMD ["rails", "server", "-b", "0.0.0.0"]
