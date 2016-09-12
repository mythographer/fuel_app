class Waybill < ApplicationRecord
  has_many :checks, dependent: :nullify
  
  belongs_to :vehicle

  validates :doc_no, length: { maximum: 10 }, presence: true,
                     uniqueness: { case_sensitive: false }
  validates :initial_date, presence: true
  validates :final_date, presence: true
  validates :vehicle, presence: true
  validates :initial_mileage, presence: true
  validates :final_mileage, presence: true
  validates :initial_fuel, presence: true
  validates :final_fuel, presence: true
  validates :comment, length: { maximum: 255 }

  accepts_nested_attributes_for :checks, reject_if: :all_blank,
    allow_destroy: true
end
