class AddCheckStatusRefToChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :checks, :check_status, null: false, foreign_key: true
  end
end
