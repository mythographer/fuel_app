require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products :diesel
  end

  test 'should respond to name_ua' do
    assert_respond_to @product, :name_ua
  end

  # Associations.

  test 'should have zero or more filling station checks' do
    refl = Product.reflect_on_association :checks
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end

  test 'should have zero or one product-fuel-brand matcher' do
    refl = Product.reflect_on_association :products_fuel_brands
    assert_not_nil refl
    assert_equal refl.macro, :has_one
    assert_equal refl.options, { dependent: :destroy } 
  end

  # Validations.

  test 'should be valid' do
    assert @product.valid?
  end

  test 'product namea should be present' do
    @product.name_ua = nil
    assert_not @product.valid?
    assert_includes @product.errors[:name_ua], "can't be blank"
  end

  test 'product name should not be too long' do
    @product.name_ua = 'a' * 256
    assert_not @product.valid?
    assert_includes @product.errors[:name_ua],
      '255 characters is the maximum allowed'
  end

  test 'product name should be unique' do
    dup = @product.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_ua], 'has already been taken'
  end
end
