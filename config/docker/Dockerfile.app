ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

RUN useradd -m -u 1000 rails
RUN mkdir /app && chown rails /app
RUN mkdir /bundle && chown rails /bundle

USER rails

WORKDIR /app

# configure bundler
RUN bundle config set --local path /bundle
