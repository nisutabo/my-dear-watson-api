class WatsonResponse < ApplicationRecord
  belongs_to :text_input
  belongs_to :user, through: :text_input
end
