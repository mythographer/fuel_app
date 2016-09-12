require 'test_helper'

class CheckTest < ActiveSupport::TestCase
  def setup
    @check = checks :one
  end

  test 'responds to attributes' do
    assert_respond_to @check, :check_no
    assert_respond_to @check, :check_datetime
    assert_respond_to @check, :check_status
    assert_respond_to @check, :filling_station_address
    assert_respond_to @check, :product
    assert_respond_to @check, :fuel_card
    assert_respond_to @check, :quantity
    assert_respond_to @check, :unit_price
    assert_respond_to @check, :total_vat
    assert_respond_to @check, :waybill
    assert_respond_to @check, :mileage
    assert_respond_to @check, :vehicle
    assert_respond_to @check, :comment
  end

  # Associations.

  test 'should belong to check status' do
    refl = Check.reflect_on_association :check_status
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options, {}
  end
  
  test 'should belong to fuel card' do
    refl = Check.reflect_on_association :fuel_card
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  test 'should belong to product' do
    refl = Check.reflect_on_association :product
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert_equal refl.options, {}
  end

  test 'should belong to waybill' do
    refl = Check.reflect_on_association :waybill
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end
  
  test 'should belong to vehicle' do
    refl = Check.reflect_on_association :vehicle
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  test 'should belong to fuel supplier report' do
    refl = Check.reflect_on_association :fuel_supplier_report
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options[:optional]
  end

  # Validations.

  test 'should be valid' do
    assert @check.valid?
  end

  test 'check number should not be too long' do
    @check.check_no = '1' * 21
    assert_not @check.valid?
    assert_includes @check.errors[:check_no],
      'is too long (maximum is 20 characters)'
  end

  test 'check_datetime should be present' do
    @check.check_datetime = nil
    assert_not @check.valid?
    assert_includes @check.errors[:check_datetime], "can't be blank"
  end

  test 'filling station address should not be too long' do
    @check.filling_station_address = 'a' * 256
    assert_not @check.valid?
    assert_includes @check.errors[:filling_station_address],
      'is too long (maximum is 255 characters)'
  end

  test 'quantity should be present' do
    @check.quantity = nil
    assert_not @check.valid?
    assert_includes @check.errors[:quantity], "can't be blank"
  end

  test 'quantity should be greater than 0.0' do
    @check.quantity = -0.01
    assert_not @check.valid?
    assert_includes @check.errors[:quantity], 'must be greater than 0.0'
  end

  test 'unit price should be present' do
    @check.unit_price = nil
    assert_not @check.valid?
    assert_includes @check.errors[:unit_price], "can't be blank"
  end

  test 'unit price should be greater than 0.0' do
    @check.unit_price = -0.01
    assert_not @check.valid?
    assert_includes @check.errors[:unit_price], 'must be greater than 0.0'
  end

  test 'total VAT should be present' do
    @check.total_vat = nil
    assert_not @check.valid?
    assert_includes @check.errors[:total_vat], "can't be blank"
  end

  test 'total VAT should be greater than 0.0' do
    @check.total_vat = -0.01
    assert_not @check.valid?
    assert_includes @check.errors[:total_vat], 'must be greater than 0.0'
  end

  test 'mileage should be greater than 0' do
    @check.mileage = -1
    assert_not @check.valid?
    assert_includes @check.errors[:mileage], 'must be greater than 0'
  end

  test 'comment should not be too long' do
    @check.comment = 'a' * 256
    assert_not @check.valid?
    assert_includes @check.errors[:comment],
      'is too long (maximum is 255 characters)'
  end

  test 'check status should be present' do
    @check.check_status = nil
    assert_not @check.valid?
    assert_includes @check.errors[:check_status], 'must exist'
  end
end
