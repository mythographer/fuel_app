class Subject < ApplicationRecord
  has_many :vehicle_registrations

  validates :name_en, length: { maximum: 255 }, presence: true,
                      uniqueness: { case_sensitive: false }
  validates :name_ua, length: { maximum: 255 }, presence: true,
                      uniqueness: { case_sensitive: false }
end
