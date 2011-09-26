require File.join(File.dirname(__FILE__), 'tweet_store')
require File.join(File.dirname(__FILE__), 'extract')

DB = TweetStore.new

class LovinIndy < Sinatra::Base
  include Twitter::Extractor
    
  set :public, 'public'
  #set :cache, Dalli::Client.new
  #Use settings.cache.set('tweets', @tweets) to set write in memechaced
  #settings.cache.get('tweets') to read the cached object
    
  helpers do
    def twitter_search 
      Twitter::Search.new
    end
  
    def fetch_data
      @data = twitter_search.hashtag("indy").language("en").no_retweets.per_page(20)
      @mentions = twitter_search.mentioning("lovinindy").per_page(10)
      @data.each do |result|
        Extract.oembed(result)
      end
    end

  end
  
  get '/' do
    @tweets = DB.tweets
    erb :home
  end

  get '/search' do 
    @results = twitter_search.hashtag("indy").language("en").no_retweets.per_page(2).filter('links').fetch
    puts @results.first.text

    #erb :index
  end
end

# Twitter Stream
TWITTER_USERNAME = "username"
TWITTER_PASSWORD = "password"
KEYS = ["soccer", "indy", "indianapolis"]

FILTER_STREAM_URL = "https://stream.twitter.com/1/statuses/filter.json?track=#{KEYS.join(",")}"
puts FILTER_STREAM_URL

EM.schedule do
  http = EM::HttpRequest.new(FILTER_STREAM_URL).get :head => { 'Authorization' => [ TWITTER_USERNAME, TWITTER_PASSWORD ] }
  buffer = ""
  http.stream do |chunk|
    buffer += chunk
    while line = buffer.slice!(/.+\r?\n/)
      tweet = JSON.parse(line)
      tweet = Extract.oembed(tweet)
      DB.push(tweet) if tweet['text']
    end
  end
end