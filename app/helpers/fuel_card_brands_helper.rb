module FuelCardBrandsHelper
  def fuel_card_brand_list
    FuelCardBrand.order(name: :asc).pluck(:name, :id)
  end
end
