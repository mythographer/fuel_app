class RenameFillUpColumns < ActiveRecord::Migration[5.0]
  def change
    change_table :fill_ups do |t|
      t.rename :check_datetime, :fill_up_datetime
      t.rename :mileage, :odometer
      t.rename :check_status_id, :fill_up_status_id
    end
  end
end
