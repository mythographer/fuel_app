class AddFuelCardStatusRefToFuelCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :fuel_cards, :fuel_card_status, null: false, foreign_key: true
  end
end
