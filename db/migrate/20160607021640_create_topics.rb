class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :title
      t.text :content
      t.integer :clicked, :default => 0

      t.timestamps null: false
    end
  end
end
