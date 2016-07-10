class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.attachment :photo
      t.integer :topic_id, :index => true

      t.timestamps null: false
    end
    #add_index :photos, :topic_id
  end
end
