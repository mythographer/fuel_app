require 'test_helper'

class GearboxTest < ActiveSupport::TestCase
  def setup
    @mechanical = gearboxes :mechanical
  end

  test 'responds to name_en, name_ua, automatic' do
    %i(name_en name_ua automatic).each do |attr|
      assert_respond_to @mechanical, attr
    end
  end

  test 'should be valid' do
    assert @mechanical.valid?
  end

  test ':name_en should be present' do
    @mechanical.name_en = nil 
    assert_not @mechanical.valid?
    assert @mechanical.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @mechanical.name_en = 'a' * 21
    assert_not @mechanical.valid?
    assert @mechanical.errors.added? :name_en, :too_long, count: 20
  end

  test 'should reject duplicate :name_en' do
    mechanical_dup = @mechanical.dup
    mechanical_dup.name_en.upcase!
    assert_not mechanical_dup.valid?
    assert mechanical_dup.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @mechanical.name_ua = nil
    assert_not @mechanical.valid?
    assert @mechanical.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @mechanical.name_ua = 'a' * 21
    assert_not @mechanical.valid?
    assert @mechanical.errors.added? :name_ua, :too_long, count: 20
  end

  test 'should reject duplicate :name_ua' do
    mechanical_dup = @mechanical.dup
    mechanical_dup.name_ua.mb_chars.upcase!
    assert_not mechanical_dup.valid?
    assert mechanical_dup.errors.added? :name_ua, :taken
  end

  test ':automatic should be present' do
    @mechanical.automatic = nil
    assert_not @mechanical.valid?
    assert @mechanical.errors.added? :automatic, :inclusion
  end
end
