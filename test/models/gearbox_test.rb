require 'test_helper'

class GearboxTest < ActiveSupport::TestCase
  def setup
    @mechanical = gearboxes :mechanical
  end

  test 'responds to name_en, name_ua, automatic' do
    [:name_en, :name_ua, :automatic].each do |attr|
      assert_respond_to @mechanical, attr
    end
  end

  test 'should be valid' do
    assert @mechanical.valid?
  end

  test 'english name should be present' do
    @mechanical.name_en = nil 
    assert_not @mechanical.valid?
    assert_includes @mechanical.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @mechanical.name_en = 'a' * 21
    assert_not @mechanical.valid?
    assert_includes @mechanical.errors[:name_en],
      'is too long (maximum is 20 characters)'
  end

  test 'english name should be unique' do
    mechanical_dup = @mechanical.dup
    mechanical_dup.name_en.upcase!
    assert_not mechanical_dup.valid?
    assert_includes mechanical_dup.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @mechanical.name_ua = nil
    assert_not @mechanical.valid?
    assert_includes @mechanical.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @mechanical.name_ua = 'a' * 21
    assert_not @mechanical.valid?
    assert_includes @mechanical.errors[:name_ua],
      'is too long (maximum is 20 characters)'
  end

  test 'ukrainian name should be unique' do
    mechanical_dup = @mechanical.dup
    mechanical_dup.name_ua.mb_chars.upcase!
    assert_not mechanical_dup.valid?
    assert_includes mechanical_dup.errors[:name_ua], 'has already been taken'
  end

  test 'automatic should be present' do
    @mechanical.automatic = nil
    assert_not @mechanical.valid?
    assert_includes @mechanical.errors[:automatic],
      'is not included in the list'
  end
end
