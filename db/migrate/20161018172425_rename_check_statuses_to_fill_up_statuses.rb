class RenameCheckStatusesToFillUpStatuses < ActiveRecord::Migration[5.0]
  def change
    rename_table :check_statuses, :fill_up_statuses
  end
end
