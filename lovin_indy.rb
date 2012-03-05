Bundler.require

class LovinIndy < Sinatra::Base
  include Twitter::Extractor
  require 'active_record'
	set :port, ARGV[1]

  configure do
   Dir.glob(File.dirname(__FILE__) + '/models/*', &method(:require))
	end	

  set :public, 'public'

	get '/' do
		ActiveRecord::Base.establish_connection(
	    :adapter => 'mysql2',
  	  :host => 'localhost',
    	:database => "lovinindy_development",
			:username => 'root',
    	:password => 'r@dh0st',
    	:encoding => 'UTF8'
    )
 		Tweet.get_tweets
		erb :index
	end

  get '/search' do 
    @results = twitter_search.hashtag("lovinindy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
  
  run!
end
