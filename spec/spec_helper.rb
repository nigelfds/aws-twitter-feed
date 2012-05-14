require "sinatra"
require "rack/test"
require 'bundler/setup'

APP_ROOT = File.expand_path("..", File.dirname(__FILE__))

Dir[File.expand_path(File.join(APP_ROOT, "lib", "*.rb"))].each do |filename|
  require filename
end

set :run, false
set :public_folder, File.join(APP_ROOT, "public")
set :views, File.join(APP_ROOT, "views")
set :environment, :test
