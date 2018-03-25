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
    # :body     => @input,
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
    :user                       => @username,
    :password                   => @password)

    response.body
  end

  def to_symbol_helper(key)
    key.gsub(" ", "_").gsub("-", "_").gsub("&", "_and_").downcase.to_sym
  end

  def percentile_conversion_helper(value)
    (value * 100).to_i
  end

  def parse_personality(raw_personality)
    result = {}

    raw_personality.each do |trait|
      trait_name = self.to_symbol_helper(trait['name'])
      trait_percentile = self.percentile_conversion_helper(trait['percentile'])

      result[trait_name] = trait_percentile

      trait['children'].each do |category|
        category_name = self.to_symbol_helper(category['name'])
        category_percentile = self.percentile_conversion_helper(category['percentile'])

        result[category_name] = category_percentile
      end
    end

    result
  end

  def parse_needs(raw_needs)
    result = {}

    raw_needs.each do |need|
      need_name = self.to_symbol_helper(need['name'])
      need_percentile = self.percentile_conversion_helper(need['percentile'])

      result[need_name] = need_percentile
    end

    result
  end

  def parse_values(raw_values)
    result = {}

    raw_values.each do |value|
      value_name = self.to_symbol_helper(value['name'])
      value_percentile = self.percentile_conversion_helper(value['percentile'])

      result[value_name] = value_percentile
    end

    result
  end

  def parse_consumption_preferences(raw_preferences)
    result = {}

    raw_preferences.each do |category|
      category['consumption_preferences'].each do |pref|
        pref_name = self.to_symbol_helper(pref['name'])
        pref_score = pref['score'].to_i

        result[pref_name] = pref_score
      end
    end

    result
  end

  def analyze_personality
    result = {}

    raw_data = JSON.parse(self.get_data)

    result[:word_count]             = {
                                      word_count: raw_data['word_count'],
                                      word_count_message: raw_data['word_count_message']
                                      }
    result[:personality]            = self.parse_personality(raw_data['personality'])
    result[:need]                   = self.parse_needs(raw_data['needs'])
    result[:value]                  = self.parse_values(raw_data['values'])
    result[:consumption_preference] = self.parse_consumption_preferences(raw_data['consumption_preferences'])

    result
  end
end
