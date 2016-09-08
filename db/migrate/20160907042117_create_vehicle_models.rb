class CreateVehicleModels < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_models do |t|
      t.string :name_en, limit: 50, null: false
      t.string :name_ua, limit: 50, null: false
      t.references :vehicle_trademark, null: false, index: true, foreign_key: true
      t.references :vehicle_group, index: true, foreign_key: true
      t.integer :wheel_count, null: false, default: '4'

      t.timestamps
    end
    add_index :vehicle_models, [:vehicle_trademark_id, :name_en], unique: true
    add_index :vehicle_models, [:vehicle_trademark_id, :name_ua], unique: true
  end
end
