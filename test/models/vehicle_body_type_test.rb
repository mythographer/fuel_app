require 'test_helper'

class VehicleBodyTypeTest < ActiveSupport::TestCase
  def setup
    @sedan = vehicle_body_types :sedan
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @sedan, attr
    end
  end

  test 'should be valid' do
    assert @sedan.valid?
  end

  test ':name_en should be present' do
    @sedan.name_en = nil
    assert_not @sedan.valid?
    assert @sedan.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @sedan.name_en = 'a' * 21
    assert_not @sedan.valid?
    assert @sedan.errors.added? :name_en, :too_long, count: 20
  end

  test 'should reject duplicate :name_en' do
    other_sedan = @sedan.dup
    other_sedan.name_en.upcase!
    assert_not other_sedan.valid?
    assert other_sedan.errors.added? :name_en, :taken
  end
 
  test ':name_ua should be present' do
    @sedan.name_ua = nil
    assert_not @sedan.valid?
    assert @sedan.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @sedan.name_ua = 'a' * 21
    assert_not @sedan.valid?
    assert @sedan.errors.added? :name_ua, :too_long, count: 20
  end

  test 'should reject duplicate :name_ua' do
    other_sedan = @sedan.dup
    other_sedan.name_ua.mb_chars.upcase!
    assert_not other_sedan.valid?
    assert other_sedan.errors.added? :name_ua, :taken
  end
end
