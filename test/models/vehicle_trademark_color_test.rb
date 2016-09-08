require 'test_helper'

class VehicleTrademarkColorTest < ActiveSupport::TestCase
  def setup
    @pearl_black = vehicle_trademark_colors :pearl_black
  end

  test 'responds to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @pearl_black, attr
    end
  end

  test 'should be valid' do
    assert @pearl_black.valid?
  end

  test 'english name should be present' do
    @pearl_black.name_en = nil
    assert_not @pearl_black.valid?
    assert_includes @pearl_black.errors[:name_en], "can't be blank"
  end

  test 'name_en should not be too long' do
    @pearl_black.name_en = 'a' * 51
    assert_not @pearl_black.valid?
    assert_includes @pearl_black.errors[:name_en],
     'is too long (maximum is 50 characters)'
  end

  test 'english name should be unique' do
    other_color = @pearl_black.dup
    other_color.name_en.upcase!
    assert_not other_color.valid?
    assert_includes other_color.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @pearl_black.name_ua = nil
    assert_not @pearl_black.valid?
    assert_includes @pearl_black.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @pearl_black.name_ua = 'a' * 51
    assert_not @pearl_black.valid?
    assert_includes @pearl_black.errors[:name_ua],
      'is too long (maximum is 50 characters)'
  end
end
