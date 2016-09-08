class CreateEnginePowers < ActiveRecord::Migration[5.0]
  def change
    create_table :engine_powers do |t|
      t.string :name_en, limit: 5, null: false
      t.string :name_ua, limit: 5, null: false

      t.timestamps
    end
    add_index :engine_powers, :name_en, unique: true
    add_index :engine_powers, :name_ua, unique: true
  end
end
