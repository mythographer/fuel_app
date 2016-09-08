class CreateVehicleMarkBodyTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_mark_body_types do |t|
      t.string :name_en, limit: 20, null: false
      t.string :name_ua, limit: 20, null: false
      t.references :vehicle_trademark, null: false, index: true,
        foreign_key: true
      t.references :vehicle_body_type, null: false, index: true,
        foreign_key: true

      t.timestamps
    end
    add_index :vehicle_mark_body_types, [:vehicle_trademark_id, :name_en],
      unique: true, name: 'uk_vehicle_mark_body_types_on_vehicle_tm_id_and_name_en'
    add_index :vehicle_mark_body_types, [:vehicle_trademark_id, :name_ua],
      unique: true, name: 'uk_vehicle_mark_body_types_on_vehicle_tm_id_and_name_ua'
  end
end
