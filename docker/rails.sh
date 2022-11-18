#!/bin/sh
#echo "Migrate database"
#bundle exec rails db:migrate
echo "Starting Rails..."
bundle exec rails s -u puma
