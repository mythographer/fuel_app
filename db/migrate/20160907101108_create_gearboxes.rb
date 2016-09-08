class CreateGearboxes < ActiveRecord::Migration[5.0]
  def change
    create_table :gearboxes do |t|
      t.string :name_en, limit: 20, null: false
      t.string :name_ua, limit: 20, null: false
      t.boolean :automatic, null: false, default: false

      t.timestamps
    end
    add_index :gearboxes, :name_en, unique: true
    add_index :gearboxes, :name_ua, unique: true
  end
end
