class CreateVehicleTrademarkColors < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_trademark_colors do |t|
      t.string :name_en, limit: 50, null: false
      t.string :name_ua, limit: 50, null: false

      t.timestamps
    end
    add_index :vehicle_trademark_colors, :name_en, unique: true
  end
end
