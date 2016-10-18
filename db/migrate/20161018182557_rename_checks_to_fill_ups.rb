class RenameChecksToFillUps < ActiveRecord::Migration[5.0]
  def change
    rename_table :checks, :fill_ups
  end
end
