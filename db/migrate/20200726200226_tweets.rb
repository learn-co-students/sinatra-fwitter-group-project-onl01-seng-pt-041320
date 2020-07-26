class Tweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |s|
      s.string :content
      s.integer :user_id
    end
  end
end
