class CreateProductsFuelBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :products_fuel_brands do |t|
      t.references :product, null: false, index: { unique: true}, foreign_key: true
      t.references :fuel_brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
