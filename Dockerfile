FROM ruby:2.6.1
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev

# RUN mkdir /codebase
# WORKDIR /codebase
# ADD Gemfile /codebase/Gemfile
# ADD Gemfile.lock /codebase/Gemfile.lock
# RUN bundle install
# ADD . /codebase

# just a test comment

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

ENV RAILS_ENV production
ENV codebase /codebase
RUN mkdir $codebase
WORKDIR $codebase
ADD . $codebase

ARG RAILS_MASTER_KEY
RUN echo $RAILS_MASTER_KEY > $codebase/config/master.key

RUN RAILS_ENV=staging rails assets:precompile
RUN RAILS_ENV=production rails assets:precompile
