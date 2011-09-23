class LovinIndy < Sinatra::Base
  include Twitter::Extractor
  set :cache, Dalli::Client.new
  
  #Use settings.cache.set('tweets', @tweets) to set write in memechaced
  #settings.cache.get('tweets') to read the cached object
  
  
  helpers do
    def twitter_search 
      Twitter::Search.new
    end
  end
  
  set :public, 'public'

  get '/' do
    embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
    @data = twitter_search.hashtag("indy").language("en").no_retweets.per_page(20)
    @mentions = twitter_search.mentioning("lovinindy").per_page(10)
    @data.each do |result|
      url = URI.extract(result.text, ['http']).first
      unless url.nil?
        obj = embedly_api.oembed :url => url
        result.embed_media_type = obj[0].type
        result.embed_media_thumb = obj[0].thumbnail_url
        result.embed_media_html = obj[0].html
        result.embed_media_provider = obj[0].provider_name
      end
    end
    erb :index
  end

  get '/search' do 
    @results = twitter_search.hashtag("indy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
end