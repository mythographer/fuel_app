class CreateVehicleTrimLevels < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_trim_levels do |t|
      t.string :name_en, limit: 50, null: false
      t.string :name_ua, limit: 50, null: false
      t.references :vehicle_model, null: false, index: true, foreign_key: true

      t.timestamps
    end
    add_index :vehicle_trim_levels, [:vehicle_model_id, :name_en], unique: true
    add_index :vehicle_trim_levels, [:vehicle_model_id, :name_ua], unique: true
  end
end
