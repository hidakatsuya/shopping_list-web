FROM ruby:3.2.0-buster

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

COPY . /app

ENV RAILS_ENV="production" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_LOG_TO_STDOUT="1"

# TODO: Since rails 7.1, use SECRET_KEY_BASE_DUMMY=1 and remove the followings.
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

RUN GSM_ENV_SKIP_LOAD=1 bundle exec rails assets:precompile

EXPOSE $PORT

RUN chmod +x /app/bin/docker-entrypoint
ENTRYPOINT ["/app/bin/docker-entrypoint"]
