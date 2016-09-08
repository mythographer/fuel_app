class VehicleInventory < ApplicationRecord
  has_many :vehicles

  belongs_to :vehicle

  validates :vehicle, presence: true
  validates :date_in, inclusion: { in: Date.new(1990, 1, 1)..Date.today },
                      uniqueness: { scope: :vehicle }, presence: true
  validates :date_out, inclusion: { in: Date.new(1990, 1, 1)..Date.today },
                       allow_nil: true
end
