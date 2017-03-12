require 'test_helper'

class FuelCardStatusTest < ActiveSupport::TestCase
  def setup
    @active = fuel_card_statuses :active
  end

  test 'should respond to name_ua, description' do
    %i(name_ua description).each do |attr|
      assert_respond_to @active, attr
    end
  end

  # Associations.

  test 'should have zero or more fuel cards' do
    refl = FuelCardStatus.reflect_on_association :fuel_cards
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end

  # Validations.

  test 'should be valid' do
    assert @active.valid?
  end

  test ':name_ua should be present' do
    @active.name_ua = nil
    assert_not @active.valid?
    assert @active.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be too long' do
    @active.name_ua = 'a' * 31
    assert_not @active.valid?
    assert @active.errors.added? :name_ua, :too_long, count: 30
  end

  test 'should reject duplicate :name_ua' do
    dup = @active.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_ua, :taken
  end

  test ':description should not be too long' do
    @active.description = 'a' * 256
    assert_not @active.valid?
    assert @active.errors.added? :description, :too_long, count: 255
  end

  # Fixtures

  test 'should be two records' do
    assert_equal 2, FuelCardStatus.count
  end

  test 'should find records' do
    h = { active: 'active', closed: 'closed' }
    h.each do |key, value|
      record = fuel_card_statuses(key)
      assert_equal value, record.name_ua
    end
  end
end
