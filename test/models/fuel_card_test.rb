require 'test_helper'

class FuelCardTest < ActiveSupport::TestCase
  def setup
    @fuel_card = fuel_cards :strong_0123456789
  end

  test 'responds to card_no, fuel_card_brand, notes' do
    [:card_no, :fuel_card_brand, :notes].each do |attr|
      assert_respond_to @fuel_card, attr
    end
  end

  test 'should be valid' do
    assert @fuel_card.valid?
  end

  test 'card number should be present' do
    @fuel_card.card_no = nil
    assert_not @fuel_card.valid?
    assert_includes @fuel_card.errors[:card_no], "can't be blank"
  end

  test 'card number should not be too long' do
    @fuel_card.card_no = '1' * 51
    assert_not @fuel_card.valid?
    assert_includes @fuel_card.errors[:card_no],
      'is too long (maximum is 50 characters)'
  end

  test 'card number should be unique' do
    dup = @fuel_card.dup
    dup.card_no.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:card_no], 'has already been taken'
  end

  test 'card number may have the same name for different brands' do
    other_brand_fuel_card = @fuel_card.dup
    other_brand_fuel_card.fuel_card_brand = fuel_card_brands :smart
    assert other_brand_fuel_card.valid?
  end

  test 'fuel card brand should be present' do
    @fuel_card.fuel_card_brand = nil
    assert_not @fuel_card.valid?
    assert_includes @fuel_card.errors[:fuel_card_brand], 'must exist'
    assert_includes @fuel_card.errors[:fuel_card_brand], "can't be blank"
  end

  test 'notes should not be too long' do
    @fuel_card.notes = 'a' * 256
    assert_not @fuel_card.valid?
    assert_includes @fuel_card.errors[:notes],
      'is too long (maximum is 255 characters)'
  end
end
