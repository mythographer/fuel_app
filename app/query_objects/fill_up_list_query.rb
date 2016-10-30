class FillUpListQuery
  def self.call
    FillUp.select(:id, :fill_up_datetime, :filling_station_address, :quantity,
           :unit_price, :odometer, :comment, :vehicle_id)
      .joins(:fuel_card, :product)
      .left_outer_joins(vehicle: [:vehicle_registration, { vehicle_configuration:
              { vehicle_bodywork: { vehicle_model: :vehicle_trademark }}}])
      .merge(FuelCard.select('"fuel_cards"."card_no"'))
      .merge(Product.select('"products"."name_ua" as "product_name"'))
      .merge(VehicleRegistration.select('"vehicle_registrations"."reg_no"'))
      .merge(Vehicle.select('"vehicles"."vin"'))
      .merge(VehicleModel.select('"vehicle_models"."name_en" as "vehicle_model"'))
      .merge(VehicleTrademark.select('"vehicle_trademarks"."name_en" as "vehicle_make"'))
      .order(id: :desc)
  end
end
