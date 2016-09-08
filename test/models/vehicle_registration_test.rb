require 'test_helper'

class VehicleRegistrationTest < ActiveSupport::TestCase
  def setup
    @doc = vehicle_registrations :one
  end

  test 'responds to doc_series, doc_no, reg_date, vro_subject, temporary, vin,
    reg_no, manufacture_year, vehicle_registration_color, total_weight,
    engine_capacity_cc, seating_capacity, special_notes, ext_reference,
    without_sn, vehicle_body_type, vehicle' do
    [:doc_series, :doc_no, :reg_date, :vro_subject, :temporary, :vin, :reg_no,
     :manufacture_year, :vehicle_registration_color, :total_weight,
     :engine_capacity_cc, :seating_capacity, :special_notes, :ext_reference, 
     :without_sn, :vehicle_body_type, :vehicle].each do |attr|
      assert @doc.respond_to? attr
    end
  end

  test 'should be valid' do
    assert @doc.valid?
  end

  test 'date of registration should be present' do
    @doc.reg_date = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:reg_date], "can't be blank"
  end

  test 'date of registration should not be in the future' do
    @doc.reg_date = Date.tomorrow
    assert_not @doc.valid?
    assert_includes @doc.errors[:reg_date], 'is not included in the list'
  end

  test 'temporary flag value should be present' do
    @doc.temporary = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:temporary], 'is not included in the list'
  end

  test 'VIN should be present' do
    @doc.vin = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:vin], "can't be blank"
  end

  test 'VIN should be entered in upper case' do
    @doc.vin.downcase!
    assert_not @doc.valid?
    assert_includes @doc.errors[:vin], 'wrong VIN'
  end

  test 'VIN should not be too long' do
    @doc.vin = '2FMZA51U0WBD539570000000000'
    assert_not @doc.valid?
    assert_includes @doc.errors[:vin], 'wrong VIN'
  end

  test 'vehicle registration number should be present' do
    @doc.reg_no = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:reg_no], "can't be blank"
  end

  test 'vehicle registration number should not be too long' do
    @doc.reg_no = 'a' * 11
    assert_not @doc.valid?
    assert_includes @doc.errors[:reg_no],
      'is too long (maximum is 10 characters)'
  end

  test 'year of manufacture should be present' do
    @doc.manufacture_year = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:manufacture_year], "can't be blank"
  end

  test 'year of manufacture should be greater than or equal to 1990' do
    @doc.manufacture_year = 1990
    assert @doc.valid?
  end

  test 'year of manufacture should be less than or equal to 2050' do
    @doc.manufacture_year = 2050
    assert @doc.valid?
  end

  test 'year of manufacture should not be less than 1990' do
    @doc.manufacture_year = 1989
    assert_not @doc.valid?
    assert_includes @doc.errors[:manufacture_year],
      'must be greater than or equal to 1990'
  end

  test 'year of manufacture should not be greater than 2050' do
    @doc.manufacture_year = 2051
    assert_not @doc.valid?
    assert_includes @doc.errors[:manufacture_year],
      'must be less than or equal to 2050'
  end

  test 'registration color should be present' do
    @doc.vehicle_registration_color = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:vehicle_registration_color], "can't be blank"
  end

  test 'total weight should be greater than 0' do
    @doc.total_weight = 1
    assert @doc.valid?
  end

  test 'total weight should not be less than or equal to 0' do
    @doc.total_weight = 0
    assert_not @doc.valid?
    assert_includes @doc.errors[:total_weight], 'must be greater than 0'
  end

  test 'engine capacity should be greater than 0' do
    @doc.engine_capacity_cc = 1
    assert @doc.valid?
  end

  test 'engine capacity should not be less than or equal to 0' do
    @doc.engine_capacity_cc = 0
    assert_not @doc.valid?
    assert_includes @doc.errors[:engine_capacity_cc], 'must be greater than 0'
  end

  test 'seating capacity should be greater than or equal to 0' do
    @doc.seating_capacity = 0
    assert @doc.valid?
  end

  test 'seating capacity should not be less than 0' do
    @doc.seating_capacity = -1
    assert_not @doc.valid?
    assert_includes @doc.errors[:seating_capacity],
      'must be greater than or equal to 0'
  end

  test 'special notes should not be too long' do
    @doc.special_notes = 'a' * 256
    assert_not @doc.valid?
    assert_includes @doc.errors[:special_notes],
      'is too long (maximum is 255 characters)'
  end

  test 'reference should not be too long' do
    @doc.ext_reference = 'a' * 256
    assert_not @doc.valid?
    assert_includes @doc.errors[:ext_reference],
      'is too long (maximum is 255 characters)'
  end

  test 'without serial number flag should be present' do
    @doc.without_sn = nil
    assert_not @doc.valid?
    assert_includes @doc.errors[:without_sn], "is not included in the list"
  end

  test 'document series should be unique for same document number' do
    dup = @doc.dup
    dup.doc_series.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:doc_series], 'has already been taken'
  end

  test 'document number should be unique for same document series' do
    dup = @doc.dup
    dup.doc_no.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:doc_series], 'has already been taken'
  end

  test 'should return document series and number' do
    assert_equal @doc.serial_no, 'ААА 0123456789'
  end
end
