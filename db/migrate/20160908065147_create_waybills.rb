class CreateWaybills < ActiveRecord::Migration[5.0]
  def change
    create_table :waybills do |t|
      t.string :doc_no, limit: 10, null: false
      t.date :initial_date, null: false
      t.date :final_date, null: false
      t.references :vehicle, null: false, index: true, foreign_key: true
      t.integer :initial_mileage, null: false
      t.integer :final_mileage, null: false
      t.integer :initial_fuel, null: false
      t.integer :final_fuel, null: false
      t.text :comment, limit: 255

      t.timestamps
    end
    add_index :waybills, :doc_no, unique: true
  end
end
