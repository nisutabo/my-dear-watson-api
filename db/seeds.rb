# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

seed_twitter_handles = [
  'realDonaldTrump',
  'BarackObama',
  'justinbieber',
  'selenagomez',
  'Cristiano',
  'rihanna',
  'taylorswift13',
  'KylieJenner',
  'BillGates',
  'Drake'
]

seed_twitter_handles.each do |twitter_handle|
  account = TwitterAccount.create(handle: twitter_handle)

  twitter_controller = Api::V1::TwitterApiController.new
  input = twitter_controller.get_tweet_text(account.handle)

  watson_controller = Api::V1::WatsonApiController.new
  analysis = watson_controller.analyze(input)

  word_counts = account.build_word_count(analysis[:word_count])
  word_counts.save

  personalities = account.build_personality(analysis[:personality])
  personalities.save

  needs = account.build_need(analysis[:need])
  needs.save

  values = account.build_value(analysis[:value])
  values.save

  consumption_preferences = account.build_consumption_preference(analysis[:consumption_preference])
  consumption_preferences.save
end
