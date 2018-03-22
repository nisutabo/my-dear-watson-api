class CreateWatsonResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :watson_responses do |t|
      t.string :analysis
      t.integer :text_input_id
      t.timestamps
    end
  end
end
