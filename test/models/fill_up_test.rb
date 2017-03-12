require 'test_helper'

class FillUpTest < ActiveSupport::TestCase
  def setup
    @fill_up = fill_ups :one
  end

  test 'responds to attributes' do
    %i(check_no fill_up_datetime fill_up_status filling_station_address product
       fuel_card quantity unit_price total_vat waybill odometer vehicle
       comment).each do |attr|
      assert_respond_to @fill_up, attr
    end
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

  test ':check_no should not be too long' do
    @fill_up.check_no = '1' * 21
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :check_no, :too_long, count: 20
  end

  test ':fill_up_datetime should be present' do
    @fill_up.fill_up_datetime = nil
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :fill_up_datetime, :blank
  end

  test ':filling_station_address should not be too long' do
    @fill_up.filling_station_address = 'a' * 256
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :filling_station_address, :too_long, count: 255
  end

  test ':quantity should be present' do
    @fill_up.quantity = nil
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :quantity, :blank
  end

  test ':quantity should be greater than 0.0' do
    @fill_up.quantity = -0.01
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :quantity, :greater_than, count: 0.0
  end

  test ':unit_price should be present' do
    @fill_up.unit_price = nil
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :unit_price, :blank
  end

  test ':unit_price should be greater than 0.0' do
    @fill_up.unit_price = -0.01
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :unit_price, :greater_than, count: 0.0
  end

  test ':total_vat should be present' do
    @fill_up.total_vat = nil
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :total_vat, :blank
  end

  test ':total_vat should be greater than 0.0' do
    @fill_up.total_vat = -0.01
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :total_vat, :greater_than, count: 0.0
  end

  test ':odometer reading should be greater than 0' do
    @fill_up.odometer = -1
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :odometer, :greater_than, count: 0
  end

  test ':comment should not be too long' do
    @fill_up.comment = 'a' * 256
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :comment, :too_long, count: 255
  end

  test ':fill_up_status should be present' do
    @fill_up.fill_up_status = nil
    assert_not @fill_up.valid?
    assert @fill_up.errors.added? :fill_up_status, :required
  end

  # Fixtures

  test 'should be one record' do
    assert_equal 1, FillUp.count
  end

  test 'should find record' do
    assert_equal '1234567890', @fill_up.check_no
  end
end
