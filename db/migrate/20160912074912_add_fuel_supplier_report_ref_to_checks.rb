class AddFuelSupplierReportRefToChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :checks, :fuel_supplier_report, foreign_key: true
  end
end
