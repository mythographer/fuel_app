class RenameFuelChecksToChecks < ActiveRecord::Migration[5.0]
  def change
    rename_table :fuel_checks, :checks
  end
end
