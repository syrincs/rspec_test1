FROM ruby:2.6.1
RUN apt-get update -qq
RUN apt-get install -y build-essential libpq-dev
RUN mkdir /codebase
WORKDIR /codebase
ADD Gemfile /codebase/Gemfile
ADD Gemfile.lock /codebase/Gemfile.lock
RUN bundle install
ADD . /codebase
