require 'test_helper'

class ProductsFuelBrandTest < ActiveSupport::TestCase
  def setup
    @one = products_fuel_brands :one
  end

  test 'responds to product, fuel_brand' do
    %i(product fuel_brand).each do |attr|
      assert_respond_to @one, attr
    end
  end

  # Associations.

  test 'should belong to product' do
    refl = ProductsFuelBrand.reflect_on_association :product
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options, {}
  end

  test 'should belong to fuel brand' do
    refl = ProductsFuelBrand.reflect_on_association :fuel_brand
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options, {}
  end
  
  # Validations.

  test 'should be valid' do
    assert @one.valid?
  end

  test ':product should be present' do
    @one.product = nil
    assert_not @one.valid?
    assert @one.errors.added? :product, :required
  end

  test ':fuel_brand should be present' do
    @one.fuel_brand = nil
    assert_not @one.valid?
    assert @one.errors.added? :fuel_brand, :required
  end

  test 'should reject duplicate :product' do
    dup = @one.dup
    assert_not dup.valid?
    assert dup.errors.added? :product, :taken
  end
end
