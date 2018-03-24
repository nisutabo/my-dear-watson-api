class CreateWordCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :word_counts do |t|
      t.integer :twitter_account_id
      t.integer :word_count
      t.timestamps
    end
  end
end
