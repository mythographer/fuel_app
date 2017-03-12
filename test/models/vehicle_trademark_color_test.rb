require 'test_helper'

class VehicleTrademarkColorTest < ActiveSupport::TestCase
  def setup
    @pearl_black = vehicle_trademark_colors :pearl_black
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @pearl_black, attr
    end
  end

  test 'should be valid' do
    assert @pearl_black.valid?
  end

  test ':name_en should be present' do
    @pearl_black.name_en = nil
    assert_not @pearl_black.valid?
    assert @pearl_black.errors.added? :name_en, :blank
  end

  test ':name_en should not be too long' do
    @pearl_black.name_en = 'a' * 51
    assert_not @pearl_black.valid?
    assert @pearl_black.errors.added? :name_en, :too_long, count: 50
  end

  test 'should reject duplicate :name_en' do
    other_color = @pearl_black.dup
    other_color.name_en.upcase!
    assert_not other_color.valid?
    assert other_color.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @pearl_black.name_ua = nil
    assert_not @pearl_black.valid?
    assert @pearl_black.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @pearl_black.name_ua = 'a' * 51
    assert_not @pearl_black.valid?
    assert @pearl_black.errors.add :name_ua, :too_long, count: 50
  end
end
