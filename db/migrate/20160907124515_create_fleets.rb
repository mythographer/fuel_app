class CreateFleets < ActiveRecord::Migration[5.0]
  def change
    create_table :fleets do |t|
      t.string :name_en, limit: 30, null: false
      t.string :name_ua, limit: 30, null: false

      t.timestamps
    end
    add_index :fleets, :name_en, unique: true
    add_index :fleets, :name_ua, unique: true
  end
end
