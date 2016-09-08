class CreateFuelChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_checks do |t|
      t.string :check_no, limit: 20
      t.datetime :check_datetime, null: false
      t.references :fuel_card, index: true, foreign_key: true
      t.references :fuel_brand, null: false, index: true, foreign_key: true
      t.decimal :quantity, precision: 6, scale: 2, null: false
      t.decimal :unit_price, precision: 15, scale: 2, null: false
      t.decimal :total_vat, precision: 15, scale: 2, null: false
      t.references :waybill, index: true, foreign_key: true
      t.integer :mileage
      t.references :vehicle, index: true, foreign_key: true
      t.text :comment, limit: 255

      t.timestamps
    end
  end
end
