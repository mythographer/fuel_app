module FuelCardBrandsHelper
  def fuel_card_brand_list
    FuelCardBrand.order(brand_name: :asc).pluck(:brand_name, :id)
  end
end
