class CreateVehicleCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_categories do |t|
      t.string :name_en, limit: 25, null: false
      t.string :name_ua, limit: 25, null: false

      t.timestamps
    end
    add_index :vehicle_categories, :name_en, unique: true
    add_index :vehicle_categories, :name_ua, unique: true
  end
end
