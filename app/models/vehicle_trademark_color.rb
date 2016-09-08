class VehicleTrademarkColor < ApplicationRecord
  has_many :vehicles

  validates :name_en, length: { maximum: 50 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 50 }, presence: true
end
