class TwitterAccount < ApplicationRecord
  has_one :word_count
  has_one :personality
  has_one :need
  has_one :value
  has_one :consumption_preference
end
