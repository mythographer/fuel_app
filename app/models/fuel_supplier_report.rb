class FuelSupplierReport < ApplicationRecord
  belongs_to :fuel_card_brand
  has_many :checks

  validates :start_date, presence: true,
    date: { before_or_equal_to: Date.current,
            message: "can't be in the future" },
    uniqueness: { scope: [:fuel_card_brand] }
  validates :end_date,
    date: { after_or_equal_to: :start_date,
            message: "must be after or equal to start date" }
  validates :end_date,
    date: { before_or_equal_to: Date.current,
            message: "can't be in the future" }
end
