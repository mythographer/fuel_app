class FuelCard < ApplicationRecord
  has_many :checks

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

  def self.fuel_card_brand_list
    FuelCardBrand.order(brand_name: :asc).pluck(:brand_name, :id)
  end

  def self.fuel_card_status_list
    FuelCardStatus.order(name_ua: :asc).pluck(:name_ua, :id)
  end
end
