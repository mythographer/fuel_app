require 'test_helper'

class FuelTypeTest < ActiveSupport::TestCase
  def setup
    @petrol = fuel_types :petrol
  end

  test 'responds to name_en, name_ua, abbr_name' do
    [:name_en, :name_ua, :abbr_name].each do |attr|
      assert_respond_to @petrol, attr
    end
  end

  test 'should be valid' do
    assert @petrol.valid?
  end

  test 'english name should be present' do
    @petrol.name_en = nil 
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @petrol.name_en = 'a' * 11
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:name_en],
      'is too long (maximum is 10 characters)'
  end

  test 'english name should be unique' do
    petrol_dup = @petrol.dup
    petrol_dup.name_en.upcase!
    assert_not petrol_dup.valid?
    assert_includes petrol_dup.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @petrol.name_ua = nil
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @petrol.name_ua = 'a' * 11
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:name_ua],
      'is too long (maximum is 10 characters)'
  end

  test 'ukrainian name should be unique' do
    petrol_dup = @petrol.dup
    petrol_dup.name_ua.mb_chars.upcase!
    assert_not petrol_dup.valid?
    assert_includes petrol_dup.errors[:name_ua], 'has already been taken'
  end

  test 'abbreviation should be present' do
    @petrol.abbr_name = nil
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:abbr_name], "can't be blank"
  end

  test 'abbreviation should not be too long' do
    @petrol.abbr_name = 'a' * 2
    assert_not @petrol.valid?
    assert_includes @petrol.errors[:abbr_name],
      'is the wrong length (should be 1 character)'
  end

  test 'abbreviation should be unique' do
    petrol_dup = @petrol.dup
    petrol_dup.abbr_name.upcase!
    assert_not petrol_dup.valid?
    assert_includes petrol_dup.errors[:abbr_name], 'has already been taken'
  end
end
