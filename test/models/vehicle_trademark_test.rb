require 'test_helper'

class VehicleTrademarkTest < ActiveSupport::TestCase
  def setup
    @ford = vehicle_trademarks :ford
  end

  test 'responds to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @ford, attr
    end
  end

  test 'should be valid' do
    @ford.valid?
  end

  test 'english trademark name should be present' do
    @ford.name_en = nil
    assert_not @ford.valid?
    assert @ford.errors[:name_en].include? "can't be blank"
  end

  test 'english trademark name should not be too long' do
    @ford.name_en = 'a' * 51
    assert_not @ford.valid?
    assert @ford.errors[:name_en].include?\
      "is too long (maximum is 50 characters)"
  end

  test 'english trademark name should be unique' do
    other_tm = @ford.dup
    other_tm.name_en.upcase!
    assert_not other_tm.valid?
    assert other_tm.errors[:name_en].include? 'has already been taken'
  end

  test 'ukrainian trademark name should be present' do
    @ford.name_ua = nil
    assert_not @ford.valid?
    assert @ford.errors[:name_ua] .include? "can't be blank"
  end

  test 'urkainian trademark name should not be too long' do
    @ford.name_ua = 'a' * 51
    assert_not @ford.valid?
    assert @ford.errors[:name_ua].include?\
      "is too long (maximum is 50 characters)"
  end

  test 'urkainian trademark name should be unique' do
    other_tm = @ford.dup
    other_tm.name_ua.mb_chars.upcase!
    assert_not other_tm.valid?
    assert other_tm.errors[:name_ua].include? 'has already been taken'
  end
end
