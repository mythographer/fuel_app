module FuelCardsHelper
  def fuel_card_list
    FuelCard.order(card_no: :asc).pluck(:card_no, :id)
  end
end
