module ProductsHelper
  def product_list
    Product.order(name_ua: :asc).pluck(:name_ua, :id)
  end
end
