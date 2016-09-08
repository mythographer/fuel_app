class CostCentre < ApplicationRecord
  has_many :vehicles

  validates :name_en, length: { maximum: 30 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 30 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
