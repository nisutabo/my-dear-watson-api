class TextInput < ApplicationRecord
  belongs_to :user
  has_one :watson_response
end
