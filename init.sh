#!/usr/bin/env bash

touch Gemfile.lock
(echo "source 'https://rubygems.org'"; echo "gem 'rails', '5.1.0'") >> Gemfile

docker-compose build

docker-compose run --rm rails rails new . --webpack=vue --force --database=mysql --skip-test
docker-compose run --rm rails rails webpack:install:vue

cp template/database.yml config/database.yml

docker-compose run --rm rails bundle exec spring binstub --all

docker-compose run --rm spring rails db:create
docker-compose run --rm spring rails db:migrate