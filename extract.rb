require 'uri'
require 'embedly'

module Extract
  extend self
  
  def embedly
    Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
  end
  
  def oembed(result)
    url = URI.extract(result['text'], ['http']).first
    unless url.nil?
      result['embed'] = embedly.oembed :url => url
      puts result['embed']
    end
    result
  end
end