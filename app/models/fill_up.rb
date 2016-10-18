class FillUp < ApplicationRecord
  belongs_to :check_status, class_name: 'FillUpStatus'
  belongs_to :fuel_card, optional: true
  belongs_to :product
  belongs_to :waybill, optional: true
  belongs_to :vehicle, optional: true
  belongs_to :fuel_supplier_report, optional: true

  validates :check_no, length: { maximum: 20 }
  validates :check_datetime, presence: true
  validates :filling_station_address, length: { maximum: 255 }
  validates :quantity, numericality: { greater_than: 0.0 }, presence: true
  validates :unit_price, numericality: { greater_than: 0.0 }, presence: true
  validates :total_vat, numericality: { greater_than: 0.0 }, presence: true
  validates :mileage, numericality: { greater_than: 0 }, allow_nil: true
  validates :comment, length: { maximum: 255 }


  scope :reverse_chronological, -> { order(id: :desc) }

  def total_amount_vat_included
    (unit_price * quantity).round(2)
  end

  def total_amount
    ((unit_price * quantity) / 1.2).round(2)
  end

  def fuel_brand_name_ua
    fuel_brand.try(:name_ua)
  end

  def fuel_brand_name_ua=(name)
    self.fuel_brand = FuelBrand.find_by_name_ua(name) if name.present?
  end
  
  def self.all_with_joins
    select(:id, :check_datetime, :filling_station_address, :quantity,
           :unit_price, :mileage, :comment, :vehicle_id)
      .joins(:fuel_card, :product)
      .left_outer_joins(vehicle: [:vehicle_registration, { vehicle_configuration:
              { vehicle_bodywork: { vehicle_model: :vehicle_trademark }}}])
      .reverse_chronological
      .merge(FuelCard.select('"fuel_cards"."card_no"'))
      .merge(Product.select('"products"."name_ua" as "product_name"'))
      .merge(VehicleRegistration.select('"vehicle_registrations"."reg_no"'))
      .merge(Vehicle.select('"vehicles"."vin"'))
      .merge(VehicleModel.select('"vehicle_models"."name_en" as "vehicle_model"'))
      .merge(VehicleTrademark.select('"vehicle_trademarks"."name_en" as "vehicle_make"'))
  end
end
