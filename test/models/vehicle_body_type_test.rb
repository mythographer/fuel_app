require 'test_helper'

class VehicleBodyTypeTest < ActiveSupport::TestCase
  def setup
    @sedan = vehicle_body_types :sedan
  end

  test 'responds to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @sedan, attr
    end
  end

  test 'should be valid' do
    assert @sedan.valid?
  end

  test 'english name should be present' do
    @sedan.name_en = nil
    assert_not @sedan.valid?
    assert_includes @sedan.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @sedan.name_en = 'a' * 21
    assert_not @sedan.valid?
    assert_includes @sedan.errors[:name_en],
      'is too long (maximum is 20 characters)'
  end

  test 'english name should be unique' do
    other_sedan = @sedan.dup
    other_sedan.name_en.upcase!
    assert_not other_sedan.valid?
    assert_includes other_sedan.errors[:name_en],
      'has already been taken'
  end
 
  test 'ukrainian name should be present' do
    @sedan.name_ua = nil
    assert_not @sedan.valid?
    assert_includes @sedan.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @sedan.name_ua = 'a' * 21
    assert_not @sedan.valid?
    assert_includes @sedan.errors[:name_ua],
      'is too long (maximum is 20 characters)'
  end

  test 'ukrainian name should be unique' do
    other_sedan = @sedan.dup
    other_sedan.name_ua.mb_chars.upcase!
    assert_not other_sedan.valid?
    assert_includes other_sedan.errors[:name_ua],
      'has already been taken'
  end
end
