class CreateFuelBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_brands do |t|
      t.string :name_en, limit: 10, null: false
      t.string :name_ua, limit: 10, null: false
      t.references :fuel_type, null: false, index: true, foreign_key: true

      t.timestamps
    end
    add_index :fuel_brands, :name_en, unique: true
    add_index :fuel_brands, :name_ua, unique: true
  end
end
