class CreateFuelCardStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :fuel_card_statuses do |t|
      t.string :name_ua, limit: 30, null: false, index: { unique: true }
      t.text :description, limit: 255

      t.timestamps
    end
  end
end
