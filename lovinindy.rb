require 'rubygems'
require 'sinatra'
require 'httparty'
require 'embedly'
require 'sinatra-cache'
require 'twitter-text'

include Twitter::Extractor

get '/' do
  @data = HTTParty.get("https://api.twitter.com/search.json?q=%23indy&page=1&rpp=20")['results']
  @data.each do |result|
    url = URI.extract(result, ['http'])
    embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
    obj = embedly_api.oembed :url => url
  end
  erb :index
end