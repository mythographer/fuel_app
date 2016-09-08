class CreateFuelCardBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_card_brands do |t|
      t.string :brand_name, limit: 50, null: false

      t.timestamps
    end
    add_index :fuel_card_brands, :brand_name, unique: true
  end
end
