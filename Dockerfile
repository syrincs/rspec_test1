FROM ruby:2.6.1
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV codebase /codebase
RUN mkdir $codebase
WORKDIR $codebase
ADD . $codebase

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

ENV RAILS_ENV production

RUN RAILS_ENV=staging rails assets:precompile
RUN RAILS_ENV=production rails assets:precompile
