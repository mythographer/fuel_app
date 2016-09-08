class CreateVehicleBodyworks < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_bodyworks do |t|
      t.references :vehicle_model, null: false, index: true, foreign_key: true
      t.references :vehicle_mark_body_type, null: false, index: true, foreign_key: true
      t.integer :doors_count, null: false
      t.integer :seating_capacity, null: false
      t.references :vehicle_category, full: false, index: false, foreign_key: true

      t.timestamps
    end
    add_index :vehicle_bodyworks,
              [:vehicle_model_id, :vehicle_mark_body_type_id, :doors_count,
               :seating_capacity, :vehicle_category_id],
               name: 'uk_vehicle_bodyworks'
  end
end
