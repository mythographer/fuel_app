class FuelBrand < ApplicationRecord
  has_many :engines
  has_many :fill_ups

  belongs_to :fuel_type

  validates :name_en, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 10 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
