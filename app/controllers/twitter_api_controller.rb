class TwitterApiController < ApplicationController
  attr_accessor :twitter_handle

  def initialize(twitter_handle) # 'realDonaldTrump'
   @twitter_handle = twitter_handle
  end

  @@client = Twitter::REST::Client.new do |config|
   config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
   config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
   config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

 def user_tweets
   tweets = []
   begin
   twit = @@client.user_timeline(@twitter_handle, options = {:count => 200})
   twit.each do |tweet|
     tweets << tweet.text
   end
   rescue Twitter::Error
   end

   tweets.join(" ")
 end
end
