class CreateCostCentres < ActiveRecord::Migration[5.0]
  def change
    create_table :cost_centres do |t|
      t.string :name_en, limit: 30, null: false
      t.string :name_ua, limit: 30, null: false

      t.timestamps
    end
    add_index :cost_centres, :name_en, unique: true
    add_index :cost_centres, :name_ua, unique: true
  end
end
