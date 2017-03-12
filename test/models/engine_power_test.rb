require 'test_helper'

class EnginePowerTest < ActiveSupport::TestCase
  def setup
    @kWt = engine_powers :kWt
  end

  test 'respond to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @kWt, attr
    end
  end

  test 'should be valid' do
    assert @kWt.valid?
  end
  
  test ':name_en should be present' do
    @kWt.name_en = nil
    assert_not @kWt.valid?
    assert @kWt.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @kWt.name_en = 'a' * 6
    assert_not @kWt.valid?
    assert @kWt.errors.added? :name_en, :too_long, count: 5
  end

  test 'should reject duplicate :name_en' do
    kWt_dup = @kWt.dup
    kWt_dup.name_en.upcase!
    assert_not kWt_dup.valid?
    assert kWt_dup.errors.added? :name_en, :taken
  end
  
  test ':name_ua should be present' do
    @kWt.name_ua = nil
    assert_not @kWt.valid?
    assert @kWt.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @kWt.name_ua = 'a' * 6
    assert_not @kWt.valid?
    assert @kWt.errors.added? :name_ua, :too_long, count: 5
  end

  test 'should reject duplicate :name_ua' do
    kWt_dup = @kWt.dup
    kWt_dup.name_ua.mb_chars.upcase!
    assert_not kWt_dup.valid?
    assert kWt_dup.errors.added? :name_ua, :taken
  end
end
