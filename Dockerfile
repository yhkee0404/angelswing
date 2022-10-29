#https://hub.docker.com/_/ruby/

FROM ruby:2.7.0-alpine

# https://gist.github.com/skozz/0ac405c565b41bfa21fb93e32ab69ad4
RUN apk add build-base \
    tzdata

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .