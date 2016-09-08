class Gearbox < ApplicationRecord
  has_many :vehicle_configuration

  validates :name_en, length: { maximum: 20 },
                      uniqueness: { case_sensitive: false },
                      presence: true
  validates :name_ua, length: { maximum: 20 },
                      uniqueness: { case_sensitive: false },
                      presence: true
  validates :automatic, inclusion: { in: [true, false] }
end
