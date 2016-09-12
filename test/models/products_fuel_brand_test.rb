require 'test_helper'

class ProductsFuelBrandTest < ActiveSupport::TestCase
  def setup
    @one = products_fuel_brands :one
  end

  test 'responds to product, fuel_brand' do
    assert_respond_to @one, :product
    assert_respond_to @one, :fuel_brand
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

  test 'product should be present' do
    @one.product = nil
    assert_not @one.valid?
    assert_includes @one.errors[:product], 'must exist'
  end

  test 'fuel brand should be present' do
    @one.fuel_brand = nil
    assert_not @one.valid?
    assert_includes @one.errors[:fuel_brand], 'must exist'
  end

  test 'product should be unique' do
    dup = @one.dup
    assert_not dup.valid?
    assert_includes dup.errors[:product], 'has already been taken'
  end
end
