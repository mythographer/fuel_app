class FillUpStatus < ApplicationRecord
  has_many :fill_ups
  
  validates :name, presence: true, length: { maximum: 30 },
    uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 255 }
end
