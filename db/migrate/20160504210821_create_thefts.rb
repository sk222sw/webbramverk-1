class CreateThefts < ActiveRecord::Migration
  def change
    create_table :thefts do |t|
      t.references :creator
      t.references :position

      t.datetime :time

      t.string :description

      t.timestamps null: false
    end
  end
end
