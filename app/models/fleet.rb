class Fleet < ApplicationRecord
  has_many :vehicles

  validates :name_en, length: { maximum: 30 },
                      uniqueness: { case_sensitive: false }, presence: true
  validates :name_ua, length: { maximum: 30 },
                      uniqueness: { case_sensitive: false }, presence: true
end
