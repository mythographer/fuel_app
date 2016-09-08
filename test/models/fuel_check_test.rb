require 'test_helper'

class FuelCheckTest < ActiveSupport::TestCase
  def setup
    @fuel_check = fuel_checks :one
  end

  test 'responds to check_no, check_datetime, fuel_card, fuel_brand,
       quantity, unit_price, total_vat, waybill, mileage, vehicle, comment' do
    [:check_no, :check_datetime, :fuel_card, :fuel_brand, :quantity,
     :unit_price, :total_vat, :waybill, :mileage, :vehicle,
     :comment].each do |attr|
      assert_respond_to @fuel_check, attr
    end 
  end

  test 'check number should not be too long' do
    @fuel_check.check_no = '1' * 21
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:check_no],
      'is too long (maximum is 20 characters)'
  end

  test 'check_datetime should be present' do
    @fuel_check.check_datetime = nil
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:check_datetime], "can't be blank"
  end

  test 'fuel brand should be present' do
    @fuel_check.fuel_brand = nil
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:fuel_brand], "can't be blank"
  end

  test 'quantity should be present' do
    @fuel_check.quantity = nil
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:quantity], "can't be blank"
  end

  test 'quantity should be greater than 0.0' do
    @fuel_check.quantity = -0.01
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:quantity], 'must be greater than 0.0'
  end

  test 'unit price should be present' do
    @fuel_check.unit_price = nil
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:unit_price], "can't be blank"
  end

  test 'unit price should be greater than 0.0' do
    @fuel_check.unit_price = -0.01
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:unit_price], 'must be greater than 0.0'
  end

  test 'total VAT should be present' do
    @fuel_check.total_vat = nil
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:total_vat], "can't be blank"
  end

  test 'total VAT should be greater than 0.0' do
    @fuel_check.total_vat = -0.01
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:total_vat], 'must be greater than 0.0'
  end

  test 'mileage should be greater than 0' do
    @fuel_check.mileage = -1
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:mileage], 'must be greater than 0'
  end

  test 'comment should not be too long' do
    @fuel_check.comment = 'a' * 256
    assert_not @fuel_check.valid?
    assert_includes @fuel_check.errors[:comment],
      'is too long (maximum is 255 characters)'
  end
end
