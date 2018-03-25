# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
trump = TwitterAccount.create(handle: 'realDonaldTrump')
obama = TwitterAccount.create(handle: 'BarackObama')
bieber = TwitterAccount.create(handle: 'justinbieber')
selena = TwitterAccount.create(handle: 'selenagomez')
cristiano = TwitterAccount.create(handle: 'Cristiano')
rihanna = TwitterAccount.create(handle: 'rihanna')
tswift = TwitterAccount.create(handle: 'taylorswift13')
kylie = TwitterAccount.create(handle: 'KylieJenner')
gates = TwitterAccount.create(handle: 'BillGates')
drake = TwitterAccount.create(handle: 'Drake')

seeds = [trump, obama, bieber, selena, cristiano, rihanna, tswift, kylie, gates, drake]

seeds.each do |user|
  twitter_handler = Api::V1::TwitterApiController.new
  input = twitter_handler.get_tweet_text(user.handle)

  watson_handler = Api::V1::WatsonApiController.new
  analysis = watson_handler.analyze_personality(input)

  words = user.build_word_count(analysis[:word_count])
  words.save

  personality = user.build_personality(analysis[:personality])
  personality.save

  needs = user.build_need(analysis[:need])
  needs.save

  values = user.build_value(analysis[:value])
  values.save

  consumption = user.build_consumption_preference(analysis[:consumption_preference])
  consumption.save
end
