class CheckStatus < ApplicationRecord
  has_many :checks
  
  validates :name, presence: true,
    length: { maximum: 30,
              too_long: "%{count} characters is the maximum allowed" },
    uniqueness: { case_sensitive: false }
  validates :description,
    length: { maximum: 255,
              too_long: "%{count} characters is the maximum allowed" }
end
