require 'test_helper'

class VehicleTrimLevelTest < ActiveSupport::TestCase
  def setup
    @comfort = vehicle_trim_levels :ford_focus_comfort
  end

  test 'responds to name_en, name_ua, vehicle_model' do
    %i(name_en name_ua vehicle_model).each do |attr|
      assert_respond_to @comfort, attr
    end
  end

  test 'should be valid' do
    assert @comfort.valid?
  end

  test ':name_en should be present' do
    @comfort.name_en = nil
    assert_not @comfort.valid?
    assert @comfort.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @comfort.name_en = 'a' * 51
    assert_not @comfort.valid?
    assert @comfort.errors.added? :name_en, :too_long, count: 50
  end

  test 'should reject duplicate :name_en' do
    other_trim_level = @comfort.dup
    other_trim_level.name_en.upcase!
    other_trim_level.name_ua = 'a'
    assert_not other_trim_level.valid?
    assert other_trim_level.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @comfort.name_ua = nil
    assert_not @comfort.valid?
    assert @comfort.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @comfort.name_ua = 'a' * 51
    assert_not @comfort.valid?
    assert @comfort.errors.added? :name_ua, :too_long, count: 50
  end

  test 'should reject duplicate :name_ua' do
    other_trim_level = @comfort.dup
    other_trim_level.name_en = 'a'
    other_trim_level.name_ua.mb_chars.upcase!
    assert_not other_trim_level.valid?
    assert other_trim_level.errors.add :name_ua, :taken
  end

  test ':vehicle_model should be present' do
    @comfort.vehicle_model = nil
    assert_not @comfort.valid?
    assert @comfort.errors.added? :vehicle_model, :blank
  end
end
