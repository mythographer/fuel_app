require 'test_helper'

class VehicleStatusTest < ActiveSupport::TestCase
  def setup
    @new = vehicle_statuses :new
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @new, attr
    end
  end

  test 'should be valid' do
    assert @new.valid?
  end

  test ':name_en should be present' do
    @new.name_en = nil
    assert_not @new.valid?
    assert @new.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @new.name_en = 'a' * 31
    assert_not @new.valid?
    assert @new.errors.added? :name_en, :too_long, count: 30
  end

  test 'should reject duplicate :name_en' do
    dup = @new.dup
    dup.name_en.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @new.name_ua = nil
    assert_not @new.valid?
    assert @new.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @new.name_ua = 'а' * 31
    assert_not @new.valid?
    assert @new.errors.added? :name_ua, :too_long, count: 30
  end

  test 'should reject duplicate :name_ua' do
    dup = @new.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_ua, :taken
  end
end
