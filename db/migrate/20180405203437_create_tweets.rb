class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.text :body
      t.string :image
      t.string :twitter_url

      t.timestamps
    end
  end
end
