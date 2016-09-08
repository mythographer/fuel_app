class CreateFuelTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_types do |t|
      t.string :name_en, limit: 10, null: false
      t.string :name_ua, limit: 10, null: false
      t.string :abbr_name, limit: 1, null: false

      t.timestamps
    end
    add_index :fuel_types, :name_en, unique: true
    add_index :fuel_types, :name_ua, unique: true
    add_index :fuel_types, :abbr_name, unique: true
  end
end
