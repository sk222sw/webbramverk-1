class CreateApiKeysTable < ActiveRecord::Migration
  def change
    create_table :api_keys_tables do |t|
      t.string :name, null: false
      t.string :api_key, null: false
    end
  end
end
