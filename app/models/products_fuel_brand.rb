class ProductsFuelBrand < ApplicationRecord
  belongs_to :product
  belongs_to :fuel_brand

  validates :product, uniqueness: true
end
