require 'test_helper'

class VehicleCategoryTest < ActiveSupport::TestCase
  def setup
    @passenger = vehicle_categories :passenger
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @passenger, attr
    end
  end

  test 'should be valid' do
    assert @passenger.valid?
  end

  test 'english name should be present' do
    @passenger.name_en = nil
    assert_not @passenger.valid?
    assert_includes @passenger.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @passenger.name_en = 'a' * 26
    assert_not @passenger.valid?
    assert_includes @passenger.errors[:name_en],
      'is too long (maximum is 25 characters)'
  end

  test 'english name should be unique' do
    other_category = @passenger.dup
    other_category.name_en.upcase!
    assert_not other_category.valid?
    assert_includes other_category.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @passenger.name_ua = nil
    assert_not @passenger.valid?
    assert_includes @passenger.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @passenger.name_ua = 'а' * 26
    assert_not @passenger.valid?
    assert_includes @passenger.errors[:name_ua],
      'is too long (maximum is 25 characters)'
  end

  test 'ukrainian name should be unique' do
    other_category = @passenger.dup
    other_category.name_ua.mb_chars.upcase!
    assert_not other_category.valid?
    assert_includes other_category.errors[:name_ua],
      'has already been taken'
  end
end
