class LovinIndy < Sinatra::Base
  include Twitter::Extractor
  
  helpers do
    def twitter_search 
      Twitter::Search.new
    end
  end
  
  set :public, 'public'

  get '/' do
    @data = HTTParty.get("https://api.twitter.com/search.json?q=%23indy&page=1&rpp=20")['results']
    @data.each do |result|
      url = URI.extract(result.to_s, ['http'])
      embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
      obj = embedly_api.oembed :url => url
    end
    erb :index
  end

  get '/search' do 
    @results = twitter_search.hashtag("indy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
end