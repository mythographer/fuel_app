require 'test_helper'

class VehicleStatusTest < ActiveSupport::TestCase
  def setup
    @new = vehicle_statuses :new
  end

  test 'responds to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @new, attr
    end
  end

  test 'should be valid' do
    assert @new.valid?
  end

  test 'english name should be present' do
    @new.name_en = nil
    assert_not @new.valid?
    assert_includes @new.errors[:name_en], "can't be blank"
  end

  test 'english name should not be too long' do
    @new.name_en = 'a' * 31
    assert_not @new.valid?
    assert_includes @new.errors[:name_en],
      'is too long (maximum is 30 characters)'
  end

  test 'english name should be unique' do
    dup = @new.dup
    dup.name_en.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @new.name_ua = nil
    assert_not @new.valid?
    assert_includes @new.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be too long' do
    @new.name_ua = 'а' * 31
    assert_not @new.valid?
    assert_includes @new.errors[:name_ua],
      'is too long (maximum is 30 characters)'
  end

  test 'ukrainian name should be unique' do
    dup = @new.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_ua], 'has already been taken'
  end
end
