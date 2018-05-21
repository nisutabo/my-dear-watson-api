class Api::V1::TwitterApiController < ApplicationController
  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = 	'cFWUdb6jEPne5tifWbQXAbvaJ'
    config.consumer_secret = 'wAxzbm1ZfGlq0WsarQCZHXCKiXsTih4UWo3YU2gtKKnCFJhjys'
    config.access_token = '2997557823-UJTvgRfWjwzBaowKwPNjH9JtApksambKgoB9hgO'
    config.access_token_secret = '852KWEqWxZAj5CHMTx7NgJvN1Vc1iRGB4a64jZgjR26IB'
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

 def get_avatar(twitter_handle)
  tweets = @@client.user_timeline(twitter_handle)
  tweets[0].user.profile_image_uri(size = :bigger)
 end
end
