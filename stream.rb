require File.join(File.dirname(__FILE__), 'tweet_store')
require File.join(File.dirname(__FILE__), 'extract')

require 'eventmachine'
require 'em-http-request'
require 'json'

DB = TweetStore.new

# Twitter Stream
TWITTER_USERNAME = "username"
TWITTER_PASSWORD = "password"
KEYS = ["football", "indy", "indianapolis"]

FILTER_STREAM_URL = "https://stream.twitter.com/1/statuses/filter.json?track=#{KEYS.join(",")}"
puts FILTER_STREAM_URL

EM.run do
  http = EM::HttpRequest.new(FILTER_STREAM_URL).get :head => { 'Authorization' => [ TWITTER_USERNAME, TWITTER_PASSWORD ] }
  buffer = ""
  http.stream do |chunk|
    buffer += chunk
    while line = buffer.slice!(/.+\r?\n/)
      tweet = JSON.parse(line)
      tweet = Extract.oembed(tweet)
      puts "pushing tweet"
      DB.push(tweet) if tweet['text']
    end
  end
end