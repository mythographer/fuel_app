class VehicleGroup < ApplicationRecord
  has_many :vehicle_model

  validates :name, length: { is: 1 }, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :descr, length: { maximum: 50 }
end
