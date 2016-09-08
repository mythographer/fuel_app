class EnginePower < ApplicationRecord
  has_many :engines

  validates :name_en, length: { maximum: 5 },
                      uniqueness: { case_sensitive: false }, presence: true
  validates :name_ua, length: { maximum: 5 },
                      uniqueness: { case_sensitive: false }, presence: true
end
