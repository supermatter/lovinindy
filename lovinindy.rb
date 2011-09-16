require 'rubygems'
require 'sinatra'
require 'httparty'

get '/' do
  @data = HTTParty.get("https://api.twitter.com/search.json?q=%23indy")['results']
  erb :index
end