class Tweet
	def get_tweets
		embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
    #@data = Twitter::Search.new.hashtag("indy").language("en").no_retweets.per_page(20)
    @data = Twitter.search('#indy')

    @data.each do |result|
    	url = URI.extract(result.text, ['http']).first
      unless url.nil?
      	obj = embedly_api.oembed :url => url
      	result.embedly = obj[0]
      end
    end
     @data = settings.cache.get('data')[:data]
  end
end
