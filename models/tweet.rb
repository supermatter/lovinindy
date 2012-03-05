class Tweet < ActiveRecord::Base

	def initialize(created, user, user_id, user_id_str, user_name, language, image_url, text)
		@created_at = created
		@from_user = user
		@from_user_id = user_id
		@from_user_id_str = user_id_str
		@from_user_name = user_name
		@iso_language_code = language
		@profile_image_url = image_url
		@text = text
	end
	
	def created_at
    self.send('created_at')
	end

	def from_user
		self.send('from_user')
	end

	def from_user_id
		self.send('from_user_id')
	end

	def from_user_id_str
		self.send('from_user_id_str')
	end

	def from_user_name
		self.send('from_user_name')
	end

	def iso_language_code
		self.send('iso_language_code')
	end

	def profile_image_url
		self.send('profile_image_url')
	end

	def text
		self.send('text')
	end
	
	def save
		self.save
	end
	def self.get_tweets		
		embedly_api = Embedly::API.new :key => 'a0254700e14811e08c704040d3dc5c07', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; info@supermatter.com)'
    @data = Twitter::Search.new.hashtag("indy").language("en").no_retweets.per_page(20)
    #@data = Twitter.search('#indy')
		# i = 0
		# @data.each do |result|
		#   while i < 2
		#     tweet = Tweet.new(result.created_at, result.from_user, result.from_user_id, result.from_user_id_str, result.from_user_name, result.iso_language_code, result.profile_image_url, result.text)
		#     tweet.save
		#     i += 1
		#   end
		# #   url = URI.extract(result.text, ['http']).first
		# #   unless url.nil?
    # #     obj = embedly_api.oembed :url => url
    # #     result.embedly = obj[0]
    # #   end
    # end
  end
end
