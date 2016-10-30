require 'test_helper'

class FuelCardStatusTest < ActiveSupport::TestCase
  def setup
    @active = fuel_card_statuses :active
  end

  test 'should respond to name_ua, description' do
    assert_respond_to @active, :name_ua
    assert_respond_to @active, :description
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

  test 'status name should be present' do
    @active.name_ua = nil
    assert_not @active.valid?
    assert_includes @active.errors[:name_ua], "can't be blank"
  end

  test 'status name should not be too long' do
    @active.name_ua = 'a' * 31
    assert_not @active.valid?
    assert_includes @active.errors[:name_ua],
      '30 characters is the maximum allowed'
  end

  test 'status name should be unique' do
    dup = @active.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_ua], 'has already been taken'
  end

  test 'description should not be too long' do
    @active.description = 'a' * 256
    assert_not @active.valid?
    assert_includes @active.errors[:description],
      '255 characters is the maximum allowed'
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
