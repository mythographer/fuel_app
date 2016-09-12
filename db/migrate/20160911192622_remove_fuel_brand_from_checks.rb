class RemoveFuelBrandFromChecks < ActiveRecord::Migration[5.0]
  def change
    remove_column :checks, :fuel_brand_id, null: false, index: true, foreign_key: true
  end
end
