class RenameFuelCardBrandNameColumn < ActiveRecord::Migration[5.0]
  def change
    change_table :fuel_card_brands do |t|
      t.rename :brand_name, :name
    end
  end
end
