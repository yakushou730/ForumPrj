class AddStatusToTopicsAndComments < ActiveRecord::Migration
  def change
    add_column :topics, :status, :string, :default => "draft"
    add_column :comments, :status, :string, :default => "draft"
  end
end
