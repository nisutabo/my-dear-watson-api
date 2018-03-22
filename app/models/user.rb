class User < ApplicationRecord
  has_many :text_inputs
  has_many :watson_responses, through: :text_inputs
end
