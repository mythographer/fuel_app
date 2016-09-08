class CreateVehicleBodyTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_body_types do |t|
      t.string :name_en, limit: 20, null: false
      t.string :name_ua, limit: 20, null: false

      t.timestamps
    end
    add_index :vehicle_body_types, :name_en, unique: true
    add_index :vehicle_body_types, :name_ua, unique: true
  end
end
