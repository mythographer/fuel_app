class CreateVehicleGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_groups do |t|
      t.string :name, limit: 1, null: false
      t.text :descr, limit: 50

      t.timestamps
    end
    add_index :vehicle_groups, :name, unique: true
  end
end
