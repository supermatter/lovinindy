require 'rubygems'
require 'sinatra'
require 'httparty'
require 'embedly-ruby'
require 'sinatra-cache'
require 'twitter-text'

get '/' do
  @data = HTTParty.get("https://api.twitter.com/search.json?q=%23indy&page=1&rpp=20")
  erb :index
  @
end