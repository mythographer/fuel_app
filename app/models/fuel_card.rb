class FuelCard < ApplicationRecord
  has_many :fill_ups

  belongs_to :fuel_card_brand
  belongs_to :fuel_card_status

  validates :card_no, length: { maximum: 50 }, presence: true,
                      uniqueness: { scope: [:fuel_card_brand, :card_no],
                                    case_sensitive: false }
  validates :fuel_card_brand, presence: true
  validates :fuel_card_status, presence: true
  validates :notes, length: { maximum: 255 }, allow_nil: true

  scope :reverse_chronological, -> { order(id: :desc) }

  def self.all_with_joins
    select(:id, :card_no, :notes)
      .joins(:fuel_card_brand)
      .joins(:fuel_card_status)
      .merge(FuelCardBrand.select('"fuel_card_brands"."brand_name"'))
      .merge(FuelCardStatus.select('"fuel_card_statuses"."name_ua" as "status_name"'))
      .reverse_chronological
  end
end
