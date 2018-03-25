class Api::V1::TwitterApiController < ApplicationController
  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

 def get_tweet_text(twitter_handle) # e.g. 'realDonaldTrump'
   tweets = []

   begin
     twitter_result = @@client.user_timeline(twitter_handle, options = {count: 200})
     twitter_result.each do |tweet|
       tweets << tweet.text
     end
   rescue Twitter::Error
   end

   tweets.join(" ")
 end
end
