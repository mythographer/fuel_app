class AddFillingStationAddressToCheck < ActiveRecord::Migration[5.0]
  def change
    add_column :checks, :filling_station_address, :string, limit: 255
  end
end
