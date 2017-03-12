require 'test_helper'

class VehicleRegistrationTest < ActiveSupport::TestCase
  def setup
    @doc = vehicle_registrations :one
  end

  test 'responds to doc_series, doc_no, reg_date, vro_subject, temporary, vin,
    reg_no, manufacture_year, vehicle_registration_color, total_weight,
    engine_capacity_cc, seating_capacity, special_notes, ext_reference,
    without_sn, vehicle_body_type, vehicle' do
    %i(doc_series doc_no reg_date vro_subject temporary vin reg_no
       manufacture_year vehicle_registration_color total_weight
       engine_capacity_cc seating_capacity special_notes ext_reference 
       without_sn vehicle_body_type vehicle).each do |attr|
      assert @doc.respond_to? attr
    end
  end

  test 'should be valid' do
    assert @doc.valid?
  end

  test ':reg_date should be present' do
    @doc.reg_date = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :reg_date, :blank
  end

  test ':reg_date should not be in the future' do
    @doc.reg_date = Date.tomorrow
    assert_not @doc.valid?
    assert_includes @doc.errors[:reg_date], 'is not included in the list'
  end

  test ':temporary should be present' do
    @doc.temporary = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :temporary, :inclusion
  end

  test ':vin should be present' do
    @doc.vin = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :vin, :blank
  end

  test ':vin should be entered in upper case' do
    @doc.vin.downcase!
    assert_not @doc.valid?
    assert @doc.errors.added? :vin, 'wrong VIN'
  end

  test ':vin should not be too long' do
    @doc.vin = @doc.vin + '0' * 10
    assert_not @doc.valid?
    assert @doc.errors.added? :vin, 'wrong VIN'
  end

  test ':reg_no should be present' do
    @doc.reg_no = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :reg_no, :blank
  end

  test ':reg_no should not be too long' do
    @doc.reg_no = 'a' * 11
    assert_not @doc.valid?
    assert @doc.errors.added? :reg_no, :too_long, count: 10
  end

  test ':manufacture_year should be present' do
    @doc.manufacture_year = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :manufacture_year, :blank
  end

  test ':manufacture_year should be in the range 1990..2050' do
    @doc.manufacture_year = 1989
    assert_not @doc.valid?
    assert @doc.errors.added? :manufacture_year, :greater_than_or_equal_to, count: 1990
    @doc.manufacture_year = 1990
    assert @doc.valid?
    @doc.manufacture_year = 2050
    assert @doc.valid?
    @doc.manufacture_year = 2051
    assert_not @doc.valid?
    assert @doc.errors.added? :manufacture_year, :less_than_or_equal_to, count: 2050
  end

  test ':vehicle_registration_color should be present' do
    @doc.vehicle_registration_color = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :vehicle_registration_color, :blank
  end

  test ':total_weight should be greater than 0' do
    @doc.total_weight = 0
    assert_not @doc.valid?
    assert @doc.errors.added? :total_weight, :greater_than, count: 0
  end

  test ':engine_capacity_cc should be greater than 0' do
    @doc.engine_capacity_cc = 0
    assert_not @doc.valid?
    assert @doc.errors.added? :engine_capacity_cc, :greater_than, count: 0
  end

  test ':seating_capacity should be greater than or equal to 0' do
    @doc.seating_capacity = -1
    assert_not @doc.valid?
    assert @doc.errors.added? :seating_capacity, :greater_than_or_equal_to, count: 0
  end

  test ':special_notes should not be too long' do
    @doc.special_notes = 'a' * 256
    assert_not @doc.valid?
    assert @doc.errors.added? :special_notes, :too_long, count: 255
  end

  test ':ext_reference should not be too long' do
    @doc.ext_reference = 'a' * 256
    assert_not @doc.valid?
    assert @doc.errors.added? :ext_reference, :too_long, count: 255
  end

  test ':without_sn should be present' do
    @doc.without_sn = nil
    assert_not @doc.valid?
    assert @doc.errors.added? :without_sn, :inclusion
  end

  test 'should reject duplicate :doc_series' do
    dup = @doc.dup
    dup.doc_series.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :doc_series, :taken
  end

  test 'should reject duplicate :doc_no' do
    dup = @doc.dup
    dup.doc_no.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :doc_series, :taken
  end

  test 'should return document series and number' do
    assert_equal @doc.serial_no, 'ААА 0123456789'
  end
end
