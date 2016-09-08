class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.string :name_en, limit: 255, null: false
      t.string :name_ua, limit: 255, null: false

      t.timestamps
    end
    add_index :subjects, :name_en, unique: true
    add_index :subjects, :name_ua, unique: true
  end
end
