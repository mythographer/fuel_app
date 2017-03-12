require 'test_helper'

class VehicleRegistrationColorTest < ActiveSupport::TestCase
  def setup
    @red = vehicle_registration_colors :red
  end

  test 'responds to name_ua' do
    assert_respond_to @red, :name_ua
  end

  test 'should be valid' do
    assert @red.valid?
  end

  test ':name_ua should be present' do
    @red.name_ua = nil
    assert_not @red.valid?
    assert @red.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @red.name_ua = 'a' * 21
    assert_not @red.valid?
    assert @red.errors.added? :name_ua, :too_long, count: 20
  end

  test 'should reject duplicate :name_ua' do
    dup = @red.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_ua, :taken
  end
end
