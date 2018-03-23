class CreateTwitterInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_inputs do |t|
      t.string :handle
      t.timestamps
    end
  end
end
