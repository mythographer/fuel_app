class CreateVehicles < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicles do |t|
      t.string :vin, limit: 17
      t.references :vehicle_configuration, null: false, index: true,
                                           foreign_key: true
      t.references :vehicle_trademark_color, null: false, index: true,
                                             foreign_key: true
      t.boolean :metallic, null: false, default: false
      t.references :fleet, index: true, foreign_key: true
      t.references :vehicle_status, index: true, null: false, foreign_key: true
      t.references :cost_centre, index: true, foreign_key: true

      t.timestamps
    end
    add_index :vehicles, :vin, unique: true, where: 'vin is not null'
  end
end
