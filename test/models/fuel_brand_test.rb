require 'test_helper'

class FuelBrandTest < ActiveSupport::TestCase
  def setup
    @A95 = fuel_brands :A95
  end

  test 'responds to name_en, name_ua, fuel_type' do
    [:name_en, :name_ua, :fuel_type].each do |attr|
      assert_respond_to @A95, attr
    end
  end

  # Validations.

  test 'should be valid' do
    assert @A95.valid?
  end

  test 'english name should be present' do
    @A95.name_en = nil
    assert_not @A95.valid?
    assert_includes @A95.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @A95.name_en = 'a' * 11
    assert_not @A95.valid?
    assert_includes @A95.errors[:name_en],
      'is too long (maximum is 10 characters)'
  end

  test 'english name should be unique' do
    other_brand = @A95.dup
    other_brand.name_en.upcase!
    assert_not other_brand.valid?
    assert_includes other_brand.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @A95.name_ua = nil 
    assert_not @A95.valid?
    assert_includes @A95.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @A95.name_ua = 'а' * 11
    assert_not @A95.valid?
    assert_includes @A95.errors[:name_ua],
      'is too long (maximum is 10 characters)'
  end

  test 'ukrainian name should be unique' do
    other_brand = @A95.dup
    other_brand.name_ua.mb_chars.upcase!
    assert_not other_brand.valid?
    assert_includes other_brand.errors[:name_ua], 'has already been taken'
  end

  test 'fuel type should be present' do
    @A95.fuel_type = nil
    assert_not @A95.valid?
    assert_includes @A95.errors[:fuel_type], "can't be blank"
  end
end
