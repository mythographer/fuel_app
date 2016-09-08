class CreateEngines < ActiveRecord::Migration[5.0]
  def change
    create_table :engines do |t|
      t.decimal :capacity_l, precision: 3, scale: 1, null: false
      t.integer :capacity_cc, null: false
      t.references :fuel_brand, index: true, foreign_key: true, null: false
      t.integer :power, null: false
      t.references :engine_power, index: true, foreign_key: true, null: false
      t.integer :cylinder_count, null: false, default: '4'

      t.timestamps null: false
    end
    add_index :engines, [:capacity_l, :capacity_cc, :fuel_brand_id, :power,
                         :engine_power_id], unique: true,
                         name: 'UK_engines'
  end
end
