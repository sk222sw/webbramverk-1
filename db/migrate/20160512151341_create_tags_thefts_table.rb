class CreateTagsTheftsTable < ActiveRecord::Migration
  def up
    create_table :tags_thefts do |t|
      t.integer "tag_id"
      t.integer "theft_id"
    end
    
    add_index :tags_thefts, ["tag_id", "theft_id"]
    
  end
  
  def down
    drop_table :tags_thefts
  end
end
