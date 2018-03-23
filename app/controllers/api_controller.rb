require 'watson-api-client'
require 'excon'
require 'pry'
require 'twitter'
require 'json'
require "dotenv"

[:word_count, :word_count_message, :processed_language, :personality, :needs, :values, :consumption_preferences, :warnings]

class TwitterApiCall
 Dotenv.load

 @@client = Twitter::REST::Client.new do |config|
   # config.consumer_key = `#{ENV["TWITTER_CONSUMER_KEY"]}`
   # config.consumer_secret = `#{ENV["TWITTER_CONSUMER_SECRET"]}`
   # config.access_token = `#{ENV["TWITTER_ACCESS_TOKEN"]}`
   # config.access_token_secret = `#{ENV["TWITTER_ACCESS_TOKEN_SECRET"]}`
   config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
   config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
   config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
   config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
 end

 def user_tweets(twitter_handle)
   tweets = []
   begin
   twit = @@client.user_timeline(twitter_handle, options = {:count => 200})
   twit.each do |tweet|
     tweets << tweet.text
   end
   rescue Twitter::Error
   end

   tweets.join(" ")
   binding.pry
 end
end


def get_data
  response = Excon.post('https://gateway.watsonplatform.net/personality-insights/api' + "/v3/profile",
  :body     => "Kurt Vonnegut said semicolons represent absolutely nothing and only show you’ve been to college. Does that mean they’re used by the CS grads to oppress us rogue bootcamp students? Is the ruling class really just using JavaScript semicolons to prevent us from getting jobs?


  But seriously: why do I need to put semicolons after each line of my JavaScript code? What’s the deal here?

  As with most contemporary tales, my adventure started with a google search quickly followed by aggressive internet strangers.

  I found insightful feedback such as:

  “Just use them.”
  or:

  PUT IN THE [CENSORED] SEMICOLONS!!!
  Luckily, for each troll programmer, there seems to be another thoughtful, nurturing one. Or perhaps every programmer just has two accounts. Whatever.

  Anyway, here’s the deal:

  When we do not apply semicolons ourselves, Automatic Semicolon Insertion (ASI) does it for us.
  ",
  :headers  => {
    "Content-Type"            => "text/plain",
    "Content-Language"        => "en",
    "Accept-Language"         => "en"
  },
  :query    => {
    "raw_scores"              => true,
    "consumption_preferences" => true,
    "version"                 => "10-13-2017"
  },
  :user                       => `#{ENV["WATSON_USER"]}`,
  :password                   => `#{ENV["WATSON_PASSWORD"]}` )

    puts response.body
end

def scores_to_hash
   array = []
   score_array = []
   data_object = JSON.parse(get_data, :object_class => OpenStruct)
   count = {:word_count => data_object.word_count}
   array += [data_object.personality, data_object.needs, data_object.values]

   begin
   array.each do |result|
     result.each do |score|
       score_array += [score.name.gsub(" ", "_").gsub("-", "_").downcase.to_sym, score.percentile]

     end
   end
    # binding.pry
   rescue
   end
   hash = Hash[*score_array]
   hash = hash.each_pair do |k, v|
     hash[k] = (v * 100).to_i
   end
   puts hash = count.merge!(hash)
end

# get_data

# t = TwitterApiCall.new
# t.user_tweets('realDonaldTrump')
