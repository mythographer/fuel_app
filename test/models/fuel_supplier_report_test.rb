require 'test_helper'

class FuelSupplierReportTest < ActiveSupport::TestCase
  def setup
    @one = fuel_supplier_reports :one
  end

  test 'responds to fuel_card_brand, start_date, end_date' do
    %i(fuel_card_brand start_date end_date).each do |attr|
      assert @one.respond_to? attr
    end
  end

  # Associations.

  test 'should belong to fuel card brand' do
    refl = FuelSupplierReport.reflect_on_association :fuel_card_brand
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert_equal refl.options, {}
  end

  test 'should have zero or more fill-ups' do
    refl = FuelSupplierReport.reflect_on_association :fill_ups
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end

  # Validations.

  test 'should be valid' do
    assert @one.valid?
  end

  test ':fuel_card_brand should be present' do
    @one.fuel_card_brand = nil
    assert @one.invalid?
    assert @one.errors.added? :fuel_card_brand, :required
  end

  test ':start_date should not be in the future' do
    @one.start_date = Date.tomorrow
    assert @one.invalid?
    assert_includes @one.errors[:start_date], "can't be in the future"
  end 

  test ':end_date should not be in the future' do
    @one.end_date = Date.tomorrow
    assert @one.invalid?
    assert_includes @one.errors[:end_date], "can't be in the future"
  end

  test ':end_date should be before or equal to start date' do
    @one.end_date = @one.start_date.yesterday
    assert @one.invalid?
    assert_includes @one.errors[:end_date],
      "must be after or equal to start date"
  end
end
