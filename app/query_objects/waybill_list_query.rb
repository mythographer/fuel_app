class WaybillListQuery
  def self.call
    Waybill.select(:id, :doc_no, :initial_date, :final_date)
      .joins(vehicle: [:vehicle_registration])
      .merge(VehicleRegistration.select('"vehicle_registrations"."reg_no"'))
      .order(id: :desc)
  end
end
