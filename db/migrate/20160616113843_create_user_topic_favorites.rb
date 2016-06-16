class CreateUserTopicFavorites < ActiveRecord::Migration
  def change
    create_table :user_topic_favorites do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps null: false
    end
    add_index :user_topic_favorites, :user_id
    add_index :user_topic_favorites, :topic_id
  end
end
