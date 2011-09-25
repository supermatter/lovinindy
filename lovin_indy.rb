Bundler.require

class LovinIndy < Sinatra::Base
  include Twitter::Extractor
  set :cache, Dalli::Client.new
  set :enable_cache, true
  set :port, ARGV[1]
    
  helpers do
    def twitter_search 
      Twitter::Search.new
    end
  end
  
  set :public, 'public'

  get '/' do
    if settings.cache.get('data').nil? || settings.cache.get('data')[:timestamp]+300 <= Time.now
      embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
      @data = twitter_search.hashtag("indy").language("en").no_retweets.per_page(20)
    
      @data.each do |result|
        url = URI.extract(result.text, ['http']).first
        unless url.nil?
          obj = embedly_api.oembed :url => url
          result.embedly = obj[0]
        end
      end
      settings.cache.set('data', {:data => @data, timestamp => Time.now})
    else
      @data = settings.cache.get('data')[:data]
    end
    erb :index
  end

  get '/search' do 
    @results = twitter_search.hashtag("indy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
  
  run!
end