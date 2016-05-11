class CreateThefts < ActiveRecord::Migration
  def change
    create_table :thefts do |t|
      t.references :creator

      t.datetime :time
      t.date :date
      t.string :description

      t.timestamps null: false
    end
  end
end
