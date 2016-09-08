require 'test_helper'

class VehicleMarkBodyTypeTest < ActiveSupport::TestCase
  def setup
    @ford_sedan = vehicle_mark_body_types :ford_sedan
  end

  test 'responds to name_en, name_ua, vehicle_trademark, vehicle_body_type' do
    [:name_en, :name_ua, :vehicle_trademark, :vehicle_body_type].each do |attr|
      assert_respond_to @ford_sedan, attr
    end
  end

  test 'should be valid' do
    assert @ford_sedan.valid?
  end

  test 'english name should be present' do
    @ford_sedan.name_en = nil
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @ford_sedan.name_en = 'a' * 21
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:name_en],
      'is too long (maximum is 20 characters)'
  end

  test 'english name should be unique' do
    other_vmbt = @ford_sedan.dup
    other_vmbt.name_en.upcase!
    assert_not other_vmbt.valid?
    assert_includes other_vmbt.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @ford_sedan.name_ua = nil
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @ford_sedan.name_ua = 'a' * 21
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:name_ua],
      'is too long (maximum is 20 characters)'
  end

  test 'ukrainian name should be unique' do
    other_vmbt = @ford_sedan.dup
    other_vmbt.name_ua.mb_chars.upcase!
    assert_not other_vmbt.valid?
    assert_includes other_vmbt.errors[:name_ua], 'has already been taken'
  end

  test 'vehicle trademark should be present' do
    @ford_sedan.vehicle_trademark = nil
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:vehicle_trademark], "can't be blank"
  end

  test 'vehicle body type should be present' do
    @ford_sedan.vehicle_body_type = nil
    assert_not @ford_sedan.valid?
    assert_includes @ford_sedan.errors[:vehicle_body_type], "can't be blank"
  end
end
