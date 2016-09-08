class CreateVehicleRegistrations < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_registrations do |t|
      t.string :doc_series, limit: 5
      t.string :doc_no, limit: 10
      t.boolean :without_sn, null: false, default: false
      t.date :reg_date, null: false
      t.references :vro_subject, null: true, index: true
      t.boolean :temporary, null: false, default: false
      t.string :vin, limit: 17, null: false
      t.string :reg_no, limit: 10, null: false
      t.integer :manufacture_year, null: false
      t.references :vehicle_registration_color, null: false, index: true, foreign_key: true
      t.references :vehicle_body_type, index: true, foreign_key: true
      t.integer :total_weight
      t.integer :engine_capacity_cc
      t.integer :seating_capacity
      t.text :special_notes, limit: 255
      t.text :ext_reference, limit: 255
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps
    end
    add_index :vehicle_registrations, [:doc_series, :doc_no], unique: true, where: 'without_sn'
    add_foreign_key :vehicle_registrations, :subjects, column: :vro_subject_id
  end
end
