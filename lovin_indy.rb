Bundler.require

class LovinIndy < Sinatra::Base
  include Twitter::Extractor
  set :port, ARGV[1]
    
  helpers do
    def twitter_search 
      Twitter::Search.new
    end
  end
  
  set :public, 'public'

  get '/' do

    erb :index
  end

  get '/search' do 
    @results = twitter_search.hashtag("lovinindy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
  
  run!
end
