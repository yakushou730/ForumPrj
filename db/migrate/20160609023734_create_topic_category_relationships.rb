class CreateTopicCategoryRelationships < ActiveRecord::Migration
  def change
    create_table :topic_category_relationships do |t|

      t.integer :topic_id
      t.integer :category_id

      t.timestamps null: false
    end

    add_index :topic_category_relationships, :topic_id
    add_index :topic_category_relationships, :category_id

  end
end
