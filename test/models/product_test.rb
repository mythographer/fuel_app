require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products :diesel
  end

  test 'should respond to name_ua' do
    assert_respond_to @product, :name_ua
  end

  # Associations.

  test 'should have zero or more filling station fill-ups' do
    refl = Product.reflect_on_association :fill_ups
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

  test ':name_ua should be present' do
    @product.name_ua = nil
    assert_not @product.valid?
    assert @product.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @product.name_ua = 'a' * 256
    assert_not @product.valid?
    assert @product.errors.added? :name_ua, :too_long, count: 255
  end

  test 'should reject duplicate :name_ua' do
    dup = @product.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_ua, :taken
  end

  # Fixtures

  test 'should be three records' do
    assert_equal 3, Product.count
  end

  test 'should find records' do
    h = { petrol_a95: 'Бензин А-95',
          diesel: 'Дизельне паливо',
          car_wash: 'Мийка Програма №4 Люкс' }
    h.each do |key, value|
      record = products(key)
      assert_equal value, record.name_ua
    end
  end
end
