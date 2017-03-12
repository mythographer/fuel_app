require 'test_helper'

class FuelCardBrandTest < ActiveSupport::TestCase
  def setup
    @strong = fuel_card_brands :strong
  end

  test 'responds to name' do
    assert_respond_to @strong, :name
  end

  # Associations.

  test 'should have zero or more fuel cards' do
    refl = FuelCardBrand.reflect_on_association(:fuel_cards)
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end

  # Validations.

  test 'should be valid' do
    assert @strong.valid?
  end

  test ':name should be present' do
    @strong.name = nil 
    assert_not @strong.valid?
    assert @strong.errors.added? :name, :blank
  end

  test ':name should not be too long' do
    @strong.name = 'a' * 51
    assert_not @strong.valid?
    assert @strong.errors.added? :name, :too_long, count: 50
  end

  test 'should reject duplicate :name' do
    dup = @strong.dup
    dup.name.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name, :taken
  end

  # Fixtures

  test 'should be two records' do
    assert_equal 2, FuelCardBrand.count
  end

  test 'should find records' do
    h = { strong: 'First Brand', smart: 'Second Brand' }
    h.each do |key, value|
      record = fuel_card_brands(key)
      assert_equal value, record.name
    end
  end
end
