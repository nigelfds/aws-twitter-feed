# -*- mode: ruby -*-

require 'rubygems'
require 'bundler/setup'

require './lib/twitter_feed'

set :run, false
set :public, './public'
set :views, './views'
set :environment, :production

run TwitterFeed.new