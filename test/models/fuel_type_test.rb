require 'test_helper'

class FuelTypeTest < ActiveSupport::TestCase
  def setup
    @petrol = fuel_types :petrol
  end

  test 'responds to name_en, name_ua, abbr_name' do
    %i(name_en name_ua abbr_name).each do |attr|
      assert_respond_to @petrol, attr
    end
  end

  test 'should be valid' do
    assert @petrol.valid?
  end

  test ':name_en should be present' do
    @petrol.name_en = nil 
    assert_not @petrol.valid?
    assert @petrol.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @petrol.name_en = 'a' * 11
    assert_not @petrol.valid?
    assert @petrol.errors.added? :name_en, :too_long, count: 10
  end

  test 'should reject duplicate :name_en' do
    petrol_dup = @petrol.dup
    petrol_dup.name_en.upcase!
    assert_not petrol_dup.valid?
    assert petrol_dup.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @petrol.name_ua = nil
    assert_not @petrol.valid?
    assert @petrol.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @petrol.name_ua = 'a' * 11
    assert_not @petrol.valid?
    assert @petrol.errors.added? :name_ua, :too_long, count: 10
  end

  test 'should reject duplicate :name_ua' do
    petrol_dup = @petrol.dup
    petrol_dup.name_ua.mb_chars.upcase!
    assert_not petrol_dup.valid?
    assert petrol_dup.errors.added? :name_ua, :taken
  end

  test ':abbr_name should be present' do
    @petrol.abbr_name = nil
    assert_not @petrol.valid?
    assert @petrol.errors.added? :abbr_name, :blank
  end

  test ':abbr_name should not be too long' do
    @petrol.abbr_name = 'a' * 2
    assert_not @petrol.valid?
    assert @petrol.errors.added? :abbr_name, :wrong_length, count: 1
  end

  test 'should reject duplicate :abbr_name' do
    petrol_dup = @petrol.dup
    petrol_dup.abbr_name.upcase!
    assert_not petrol_dup.valid?
    assert petrol_dup.errors.added? :abbr_name, :taken
  end
end
