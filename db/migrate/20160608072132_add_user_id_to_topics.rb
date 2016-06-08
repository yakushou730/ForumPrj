class AddUserIdToTopics < ActiveRecord::Migration

  def change
    add_column :topics, :user_id, :integer
    add_index :topics, :user_id
  end

end
