require 'test_helper'

class FuelCardTest < ActiveSupport::TestCase
  def setup
    @fuel_card = fuel_cards :strong_0123456789
  end

  test 'responds to card_no, fuel_card_brand, notes' do
    %i(card_no fuel_card_brand notes).each do |attr|
      assert_respond_to @fuel_card, attr
    end
  end

  # Associations.

  test 'should have zero or more filling station fill-ups' do
    refl = FuelCard.reflect_on_association :fill_ups
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end

  test 'should belong to fuel card brand' do
    refl = FuelCard.reflect_on_association :fuel_card_brand
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert_equal refl.options, {}
  end

  test 'should belong to fuel card status' do
    refl = FuelCard.reflect_on_association :fuel_card_status
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert_equal refl.options, {}
  end

  # Validations.

  test 'should be valid' do
    assert @fuel_card.valid?
  end

  test ':card_no should be present' do
    @fuel_card.card_no = nil
    assert_not @fuel_card.valid?
    assert @fuel_card.errors.added? :card_no, :blank
  end

  test ':card_no should not be too long' do
    @fuel_card.card_no = '1' * 51
    assert_not @fuel_card.valid?
    assert @fuel_card.errors.added? :card_no, :too_long, count: 50
  end

  test 'should reject duplicate :card_no' do
    dup = @fuel_card.dup
    dup.card_no.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :card_no, :taken
  end

  test ':card_no may have the same name for different brands' do
    other_brand_fuel_card = @fuel_card.dup
    other_brand_fuel_card.fuel_card_brand = fuel_card_brands :smart
    assert other_brand_fuel_card.valid?
  end

  test ':fuel_card_brand should be present' do
    @fuel_card.fuel_card_brand = nil
    assert_not @fuel_card.valid?
    assert @fuel_card.errors.added? :fuel_card_brand, :required
    assert @fuel_card.errors.added? :fuel_card_brand, :blank
  end

  test ':notes should not be too long' do
    @fuel_card.notes = 'a' * 256
    assert_not @fuel_card.valid?
    assert @fuel_card.errors.added? :notes, :too_long, count: 255
  end

  # Fixtures

  test 'should be one record' do
    assert_equal 1, FuelCard.count
  end

  test 'should find record' do
    fuel_card = fuel_cards(:strong_0123456789)
    assert_equal '0123456789', fuel_card.card_no
  end
end
