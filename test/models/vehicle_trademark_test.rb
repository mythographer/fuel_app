require 'test_helper'

class VehicleTrademarkTest < ActiveSupport::TestCase
  def setup
    @ford = vehicle_trademarks :ford
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @ford, attr
    end
  end

  test 'should be valid' do
    @ford.valid?
  end

  test ':name_en should be present' do
    @ford.name_en = nil
    assert_not @ford.valid?
    assert @ford.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @ford.name_en = 'a' * 51
    assert_not @ford.valid?
    assert @ford.errors.added? :name_en, :too_long, count: 50
  end

  test 'should reject duplicate :name_en' do
    other_tm = @ford.dup
    other_tm.name_en.upcase!
    assert_not other_tm.valid?
    assert other_tm.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @ford.name_ua = nil
    assert_not @ford.valid?
    assert @ford.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @ford.name_ua = 'a' * 51
    assert_not @ford.valid?
    assert @ford.errors.added? :name_ua, :too_long, count: 50
  end

  test 'should reject duplicate :name_ua' do
    other_tm = @ford.dup
    other_tm.name_ua.mb_chars.upcase!
    assert_not other_tm.valid?
    assert other_tm.errors.added? :name_ua, :taken
  end
end
