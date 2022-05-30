ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

ARG NODE_VERSION

WORKDIR /app

# configure bundler
RUN bundle config set --local path /bundle
