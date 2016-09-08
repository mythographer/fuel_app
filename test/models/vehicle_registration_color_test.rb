require 'test_helper'

class VehicleRegistrationColorTest < ActiveSupport::TestCase
  def setup
    @red = vehicle_registration_colors :red
  end

  test 'responds to name_ua' do
    [:name_ua].each do |attr|
      assert_respond_to @red, attr
    end
  end

  test 'should be valid' do
    assert @red.valid?
  end

  test 'ukrainian name should be present' do
    @red.name_ua = nil
    assert_not @red.valid?
    assert_includes @red.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @red.name_ua = 'a' * 21
    assert_not @red.valid?
    assert_includes @red.errors[:name_ua],
      'is too long (maximum is 20 characters)'
  end

  test 'ukrainian name should be unique' do
    dup = @red.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_ua], 'has already been taken'
  end
end
