require 'test_helper'

class VehicleMarkBodyTypeTest < ActiveSupport::TestCase
  def setup
    @ford_sedan = vehicle_mark_body_types :ford_sedan
  end

  test 'responds to name_en, name_ua, vehicle_trademark, vehicle_body_type' do
    %i(name_en name_ua vehicle_trademark vehicle_body_type).each do |attr|
      assert_respond_to @ford_sedan, attr
    end
  end

  test 'should be valid' do
    assert @ford_sedan.valid?
  end

  test ':name_en should be present' do
    @ford_sedan.name_en = nil
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @ford_sedan.name_en = 'a' * 21
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :name_en, :too_long, count: 20
  end

  test 'should reject duplicate :name_en' do
    other_vmbt = @ford_sedan.dup
    other_vmbt.name_en.upcase!
    assert_not other_vmbt.valid?
    assert other_vmbt.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @ford_sedan.name_ua = nil
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @ford_sedan.name_ua = 'a' * 21
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :name_ua, :too_long, count: 20
  end

  test 'should reject duplicate :name_ua' do
    other_vmbt = @ford_sedan.dup
    other_vmbt.name_ua.mb_chars.upcase!
    assert_not other_vmbt.valid?
    assert other_vmbt.errors.added? :name_ua, :taken
  end

  test ':vehicle_trademark should be present' do
    @ford_sedan.vehicle_trademark = nil
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :vehicle_trademark, :blank
  end

  test ':vehicle_body_type should be present' do
    @ford_sedan.vehicle_body_type = nil
    assert_not @ford_sedan.valid?
    assert @ford_sedan.errors.added? :vehicle_body_type, :blank
  end
end
