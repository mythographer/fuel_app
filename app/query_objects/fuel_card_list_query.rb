class FuelCardListQuery
  def self.call
    FuelCard.select(:id, :card_no, :notes)
      .joins(:fuel_card_brand)
      .joins(:fuel_card_status)
      .merge(FuelCardBrand.select('"fuel_card_brands"."name" as "brand_name"'))
      .merge(FuelCardStatus.select('"fuel_card_statuses"."name_ua" as "status_name"'))
      .order(id: :desc)
  end
end
