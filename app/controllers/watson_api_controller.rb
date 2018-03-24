class WatsonApiController < ApplicationController
  attr_accessor :url, :username, :password, :input

  def initialize(input)
     @url = "https://gateway.watsonplatform.net/personality-insights/api"
     @username = ENV["WATSON_USER"]
     @password = ENV["WATSON_PASSWORD"]
     @input = input
   end

  def get_data
    response = Excon.post(@url + "/v3/profile",
    :body     => @input,
    # :body     => "Kurt Vonnegut said semicolons represent absolutely nothing and only show you’ve been to college. Does that mean they’re used by the CS grads to oppress us rogue bootcamp students? Is the ruling class really just using JavaScript semicolons to prevent us from getting jobs?
    #
    #
    # But seriously: why do I need to put semicolons after each line of my JavaScript code? What’s the deal here?
    #
    # As with most contemporary tales, my adventure started with a google search quickly followed by aggressive internet strangers.
    #
    # I found insightful feedback such as:
    #
    # “Just use them.”
    # or:
    #
    # PUT IN THE [CENSORED] SEMICOLONS!!!
    # Luckily, for each troll programmer, there seems to be another thoughtful, nurturing one. Or perhaps every programmer just has two accounts. Whatever.
    #
    # Anyway, here’s the deal:
    #
    # When we do not apply semicolons ourselves, Automatic Semicolon Insertion (ASI) does it for us.
    # ",
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
    :user                       => @username,
    :password                   => @password)

    response.body
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
     rescue
     end
     hash = Hash[*score_array]
     hash = hash.each_pair do |k, v|
       hash[k] = (v * 100).to_i
     end
     hash = count.merge!(hash)
  end

end
