#!/usr/bin/env bash
#
# ensure RVM is installed
set -e

if [ ! -d "$HOME/.rvm" ]; then
  echo "installing rvm..."
  curl -L get.rvm.io | bash -s stable
fi

# load RVM and project config
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
rvm rvmrc trust . > /dev/null
source .rvmrc > /dev/null

# install gems using bundler
gem list | grep bundler  || gem install bundler --version 1.0.21 --no-rdoc --no-ri
bundle check || bundle install

# warble && echo -e "Run the following command to start the app on localhost:3000 \n==> java -jar aws-twitter-feed.jar"

bundle exec rake $@