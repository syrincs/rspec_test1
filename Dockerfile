FROM ruby:2.6.1
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ARG RAILS_MASTER_KEY
RUN echo $RAILS_MASTER_KEY > config/master.key
ENV RAILS_ENV production

ENV codebase /codebase
RUN mkdir $codebase
WORKDIR $codebase
ADD . $codebase

RUN RAILS_ENV=staging rails assets:precompile
RUN RAILS_ENV=production rails assets:precompile
