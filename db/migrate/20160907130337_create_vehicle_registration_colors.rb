class CreateVehicleRegistrationColors < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_registration_colors do |t|
      t.string :name_ua, limit: 20, null: false

      t.timestamps
    end
    add_index :vehicle_registration_colors, :name_ua, unique: true
  end
end
