class VehicleBodywork < ApplicationRecord
  has_many :vehicle_configurations
  
  belongs_to :vehicle_model
  belongs_to :vehicle_mark_body_type
  belongs_to :vehicle_category

  validates :vehicle_model, presence: true,
    uniqueness: {
      scope: %i(vehicle_mark_body_type doors_count seating_capacity
                vehicle_category) }
  validates :vehicle_mark_body_type, presence: true
  validates :doors_count, presence: true,
    numericality: { greater_than_or_equal_to: 0 }
  validates :seating_capacity, presence: true,
    numericality: { greater_than_or_equal_to: 0 }
  validates :vehicle_category, presence: true
end
