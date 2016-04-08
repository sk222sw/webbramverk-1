class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.references :user, index: true, foreign_key:true
      
      t.string :name
      t.string :api_key
      t.timestamps null: false
    end
  end
end
