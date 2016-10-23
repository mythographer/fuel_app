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

  test 'brand name should be present' do
    @strong.name = nil 
    assert_not @strong.valid?
    assert_includes @strong.errors[:name], 'can\'t be blank'
  end

  test 'brand name should not be too long' do
    @strong.name = 'a' * 51
    assert_not @strong.valid?
    assert_includes @strong.errors[:name],
      '50 characters is the maximum allowed'
  end

  test 'brand name should be unique' do
    dup = @strong.dup
    dup.name.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name], 'has already been taken'
  end
end
