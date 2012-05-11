require 'rubygems'
require 'sinatra'
require 'twitter'

class TwitterFeed < Sinatra::Application
  get '/' do
    hash_tag = params[:hash_tag] || 'aws'
    statuses = Twitter.search "##{hash_tag}"
    erb :index, :locals => {:statuses => statuses, :hash_tag => hash_tag }
  end
end
