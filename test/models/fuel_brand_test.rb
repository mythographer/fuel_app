require 'test_helper'

class FuelBrandTest < ActiveSupport::TestCase
  def setup
    @A95 = fuel_brands :A95
  end

  test 'responds to name_en, name_ua, fuel_type' do
    %i(name_en name_ua fuel_type).each do |attr|
      assert_respond_to @A95, attr
    end
  end

  # Validations.

  test 'should be valid' do
    assert @A95.valid?
  end

  test ':name_en should be present' do
    @A95.name_en = nil
    assert_not @A95.valid?
    assert @A95.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @A95.name_en = 'a' * 11
    assert_not @A95.valid?
    assert @A95.errors.added? :name_en, :too_long, count: 10
  end

  test 'should reject duplicate :name_en' do
    other_brand = @A95.dup
    other_brand.name_en.upcase!
    assert_not other_brand.valid?
    assert other_brand.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @A95.name_ua = nil 
    assert_not @A95.valid?
    assert @A95.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @A95.name_ua = 'а' * 11
    assert_not @A95.valid?
    assert @A95.errors.added? :name_ua, :too_long, count: 10
  end

  test 'should reject duplicate :name_ua' do
    other_brand = @A95.dup
    other_brand.name_ua.mb_chars.upcase!
    assert_not other_brand.valid?
    assert other_brand.errors.added? :name_ua, :taken
  end

  test ':fuel_type should be present' do
    @A95.fuel_type = nil
    assert_not @A95.valid?
    assert @A95.errors.added? :fuel_type, :required
  end
end
