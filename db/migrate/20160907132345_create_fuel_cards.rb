class CreateFuelCards < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_cards do |t|
      t.string :card_no, limit: 50, null: false
      t.references :fuel_card_brand, null: false, index: true, foreign_key: true
      t.text :notes, limit: 255

      t.timestamps
    end
    add_index :fuel_cards, [:fuel_card_brand_id, :card_no], unique: true
  end
end
