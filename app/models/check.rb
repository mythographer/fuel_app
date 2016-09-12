class Check < ApplicationRecord
  belongs_to :check_status
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
end
