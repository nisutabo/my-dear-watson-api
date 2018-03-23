class CreateWatsonResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :watson_responses do |t|
      t.string :analysis
      t.integer :twitter_inputs_id
      t.timestamps
    end
  end
end
