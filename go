#!/usr/bin/env bash
#
# ensure RVM is installed
set -e

if [ ! -d "$HOME/.rvm" ]; then
  bash -s stable < <(curl -k -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
fi

# load RVM and project config
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
rvm rvmrc trust . > /dev/null
source .rvmrc > /dev/null

# install gems using bundler
gem list | grep bundler  || gem install bundler --version 1.0.21 --no-rdoc --no-ri
bundle check || bundle install

warble && echo -e "Run the following command to start the app on localhost:3000 \n==> java -jar aws-twitter-feed.jar"