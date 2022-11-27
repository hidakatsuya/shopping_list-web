FROM ruby:3.1.2-buster

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install bundler && \
    bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

COPY . /app

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

ARG DB_PASSWORD
ARG DB_USERNAME
ARG DB_HOST
ARG GOOGLE_CLIENT_ID
ARG GOOGLE_CLIENT_SECRET
ARG REGISTRABLE_ACCOUNT_EMAILS
ARG SECRET_KEY_BASE
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_HOST=${DB_HOST}
ENV GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}
ENV GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}
ENV REGISTRABLE_ACCOUNT_EMAILS=${REGISTRABLE_ACCOUNT_EMAILS}
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}

RUN bundle exec rails assets:precompile

EXPOSE 8080

RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
