class CreateVehicleTrademarks < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_trademarks do |t|
      t.string :name_en, limit: 50, null: false
      t.string :name_ua, limit: 50, null: false

      t.timestamps
    end
    add_index :vehicle_trademarks, :name_en, unique: true
    add_index :vehicle_trademarks, :name_ua, unique: true
  end
end
