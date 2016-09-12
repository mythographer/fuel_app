class AddProductRefToChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :checks, :product, null: false, foreign_key: true
  end
end
