ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

# turn off auto complete in rails console
RUN echo 'IRB.conf[:USE_AUTOCOMPLETE] = false' > ~/.irbrc

WORKDIR /app

# configure bundler
RUN bundle config set --local path /bundle
