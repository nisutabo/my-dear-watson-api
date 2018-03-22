class CreateTextInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :text_inputs do |t|
      t.string :content
      t.integer :user_id
      t.timestamps
    end
  end
end
