class CreateVehicleConfigurations < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_configurations do |t|
      t.references :vehicle_bodywork, null: false,  index: true, foreign_key: true
      t.references :vehicle_trim_level, null: false, index: true, foreign_key: true
      t.references :engine, null: false, index: true, foreign_key: true
      t.references :gearbox, null: false, index: true, foreign_key: true
      t.boolean :awd, null: false, default: false
      t.integer :fuel_capacity
      
      t.timestamps
    end
  end
end
