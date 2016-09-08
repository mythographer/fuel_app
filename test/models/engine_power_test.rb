require 'test_helper'

class EnginePowerTest < ActiveSupport::TestCase
  def setup
    @kWt = engine_powers :kWt
  end

  test 'respond to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @kWt, attr
    end
  end

  test 'should be valid' do
    assert @kWt.valid?
  end
  
  test 'english name should be present' do
    @kWt.name_en = nil
    assert_not @kWt.valid?
    assert_includes @kWt.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @kWt.name_en = 'a' * 6
    assert_not @kWt.valid?
    assert_includes @kWt.errors[:name_en],
      'is too long (maximum is 5 characters)'
  end

  test 'english name should be unique' do
    kWt_dup = @kWt.dup
    kWt_dup.name_en.upcase!
    assert_not kWt_dup.valid?
    assert_includes kWt_dup.errors[:name_en], 'has already been taken'
  end
  
  test 'ukrainian name should be present' do
    @kWt.name_ua = nil
    assert_not @kWt.valid?
    assert_includes @kWt.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @kWt.name_ua = 'a' * 6
    assert_not @kWt.valid?
    assert_includes @kWt.errors[:name_ua],
      'is too long (maximum is 5 characters)'
  end

  test 'ukrainian name should be unique' do
    kWt_dup = @kWt.dup
    kWt_dup.name_ua.mb_chars.upcase!
    assert_not kWt_dup.valid?
    assert_includes kWt_dup.errors[:name_ua], 'has already been taken'
  end
end
