require 'test_helper'

class VehicleModelTest < ActiveSupport::TestCase
  def setup
    @ford_focus = vehicle_models :ford_focus
  end

  test 'responds to vehicle_trademark, name_en, name_ua, vehicle_group, '\
    'wheel_count' do
    %i(vehicle_trademark name_en name_ua vehicle_group
       wheel_count).each do |attr|
      assert_respond_to @ford_focus, attr
    end
  end

  test 'should be valid' do
    assert @ford_focus.valid?
  end
  
  test 'english name should be present' do
    @ford_focus.name_en = nil
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @ford_focus.name_en = 'a' * 51
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:name_en],
      'is too long (maximum is 50 characters)'
  end

  test 'english name should be unique' do
    other_model = @ford_focus.dup
    other_model.name_en.upcase!
    assert_not other_model.valid?
    assert_includes other_model.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @ford_focus.name_ua = nil
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @ford_focus.name_ua = 'a' * 51
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:name_ua],
      'is too long (maximum is 50 characters)'
  end

  test 'ukrainian name should be unique' do
    other_model = @ford_focus.dup
    other_model.name_ua.mb_chars.upcase!
    assert_not other_model.valid?
    assert_includes other_model.errors[:name_ua], 'has already been taken'
  end

  test 'trademark should be present' do
    @ford_focus.vehicle_trademark = nil
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:vehicle_trademark], "can't be blank"
  end

  test 'wheel count should be present' do
    @ford_focus.wheel_count = nil
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:wheel_count], "can't be blank"
  end

  test 'wheel count should be greater than 0' do
    @ford_focus.wheel_count = -1
    assert_not @ford_focus.valid?
    assert_includes @ford_focus.errors[:wheel_count], 'must be greater than 0'
  end
end
