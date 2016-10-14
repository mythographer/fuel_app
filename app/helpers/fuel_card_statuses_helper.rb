module FuelCardStatusesHelper
  def fuel_card_status_list
    FuelCardStatus.order(name_ua: :asc).pluck(:name_ua, :id)
  end
end
