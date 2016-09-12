class CreateFuelSupplierReports < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_supplier_reports do |t|
      t.references :fuel_card_brand, null: false, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date

      t.timestamps
    end
    add_index :fuel_supplier_reports, [:fuel_card_brand_id, :start_date],
      unique: true, name: 'uk_fuel_supplier_reports'
  end
end
