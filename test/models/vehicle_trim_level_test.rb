require 'test_helper'

class VehicleTrimLevelTest < ActiveSupport::TestCase
  def setup
    @comfort = vehicle_trim_levels :ford_focus_comfort
  end

  test 'responds to name_en, name_ua, vehicle_model' do
    [:name_en, :name_ua, :vehicle_model].each do |attr|
      assert_respond_to @comfort, attr
    end
  end

  test 'should be valid' do
    assert @comfort.valid?
  end

  test 'english name should be present' do
    @comfort.name_en = nil
    assert_not @comfort.valid?
    assert_includes @comfort.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @comfort.name_en = 'a' * 51
    assert_not @comfort.valid?
    assert_includes @comfort.errors[:name_en],
      'is too long (maximum is 50 characters)'
  end

  test 'english name should be unique' do
    other_trim_level = @comfort.dup
    other_trim_level.name_en.upcase!
    other_trim_level.name_ua = 'a'
    assert_not other_trim_level.valid?
    assert_includes other_trim_level.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @comfort.name_ua = nil
    assert_not @comfort.valid?
    assert_includes @comfort.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @comfort.name_ua = 'a' * 51
    assert_not @comfort.valid?
    assert_includes @comfort.errors[:name_ua],
      'is too long (maximum is 50 characters)'
  end

  test 'ukrainian name should be unique' do
    other_trim_level = @comfort.dup
    other_trim_level.name_en = 'a'
    other_trim_level.name_ua.mb_chars.upcase!
    assert_not other_trim_level.valid?
    assert_includes other_trim_level.errors[:name_ua], 'has already been taken'
  end

  test 'vehicle model should be present' do
    @comfort.vehicle_model = nil
    assert_not @comfort.valid?
    assert_includes @comfort.errors[:vehicle_model], "can't be blank"
  end
end
