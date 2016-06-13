class AddCounterAndCommentUpdatedTimeToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :comments_count, :integer, :default => 0
    add_column :topics, :comment_last_updated_at, :datetime
  end
end
