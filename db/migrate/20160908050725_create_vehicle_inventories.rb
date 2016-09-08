class CreateVehicleInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_inventories do |t|
      t.references :vehicle, null: false, index: true, foreign_key: true
      t.date :date_in, null: false
      t.date :date_out

      t.timestamps
    end
    add_index :vehicle_inventories, [:vehicle_id, :date_in], unique: true,
      name: 'uk_vehicle_inventories'
  end
end
