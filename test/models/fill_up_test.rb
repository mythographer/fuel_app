require 'test_helper'

class FillUpTest < ActiveSupport::TestCase
  def setup
    @fill_up = fill_ups :one
  end

  test 'responds to attributes' do
    assert_respond_to @fill_up, :check_no
    assert_respond_to @fill_up, :fill_up_datetime
    assert_respond_to @fill_up, :fill_up_status
    assert_respond_to @fill_up, :filling_station_address
    assert_respond_to @fill_up, :product
    assert_respond_to @fill_up, :fuel_card
    assert_respond_to @fill_up, :quantity
    assert_respond_to @fill_up, :unit_price
    assert_respond_to @fill_up, :total_vat
    assert_respond_to @fill_up, :waybill
    assert_respond_to @fill_up, :odometer
    assert_respond_to @fill_up, :vehicle
    assert_respond_to @fill_up, :comment
  end

  # Associations.

  test 'should belong to fill-up status' do
    refl = FillUp.reflect_on_association :fill_up_status
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options, {}
  end
  
  test 'should belong to fuel card' do
    refl = FillUp.reflect_on_association :fuel_card
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  test 'should belong to product' do
    refl = FillUp.reflect_on_association :product
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert_equal refl.options, {}
  end

  test 'should belong to waybill' do
    refl = FillUp.reflect_on_association :waybill
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end
  
  test 'should belong to vehicle' do
    refl = FillUp.reflect_on_association :vehicle
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  test 'should belong to fuel supplier report' do
    refl = FillUp.reflect_on_association :fuel_supplier_report
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  # Validations.

  test 'should be valid' do
    assert @fill_up.valid?
  end

  test 'check number should not be too long' do
    @fill_up.check_no = '1' * 21
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:check_no],
      'is too long (maximum is 20 characters)'
  end

  test 'fill-up datetime should be present' do
    @fill_up.fill_up_datetime = nil
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:fill_up_datetime], "can't be blank"
  end

  test 'filling station address should not be too long' do
    @fill_up.filling_station_address = 'a' * 256
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:filling_station_address],
      'is too long (maximum is 255 characters)'
  end

  test 'quantity should be present' do
    @fill_up.quantity = nil
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:quantity], "can't be blank"
  end

  test 'quantity should be greater than 0.0' do
    @fill_up.quantity = -0.01
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:quantity], 'must be greater than 0.0'
  end

  test 'unit price should be present' do
    @fill_up.unit_price = nil
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:unit_price], "can't be blank"
  end

  test 'unit price should be greater than 0.0' do
    @fill_up.unit_price = -0.01
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:unit_price], 'must be greater than 0.0'
  end

  test 'total VAT should be present' do
    @fill_up.total_vat = nil
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:total_vat], "can't be blank"
  end

  test 'total VAT should be greater than 0.0' do
    @fill_up.total_vat = -0.01
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:total_vat], 'must be greater than 0.0'
  end

  test 'odometer reading should be greater than 0' do
    @fill_up.odometer = -1
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:odometer], 'must be greater than 0'
  end

  test 'comment should not be too long' do
    @fill_up.comment = 'a' * 256
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:comment],
      'is too long (maximum is 255 characters)'
  end

  test 'fill-up status should be present' do
    @fill_up.fill_up_status = nil
    assert_not @fill_up.valid?
    assert_includes @fill_up.errors[:fill_up_status], 'must exist'
  end
end
