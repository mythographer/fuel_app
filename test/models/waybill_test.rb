require 'test_helper'

class WaybillTest < ActiveSupport::TestCase
  def setup
    @waybill = waybills :september_2016_one
  end

  test 'responds to attribute name' do
    %i(doc_no initial_date final_date vehicle initial_mileage final_mileage
       initial_fuel final_fuel comment).each do |attr|
      assert_respond_to @waybill, attr
    end
  end

  # Associations.

  test 'should have zero or more fill-ups' do
    refl = Waybill.reflect_on_association :fill_ups
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options[:dependent], :nullify
  end

  test 'should belong to vehicle' do
    refl = Waybill.reflect_on_association(:vehicle)
    assert_not_nil refl
    assert_equal refl.macro, :belongs_to
    assert refl.options, {}
  end

  # Validations.

  test ':doc_no should be present' do
    @waybill.doc_no = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :doc_no, :blank
  end

  test ':doc_no should not be too long' do
    @waybill.doc_no = 'a' * 11
    assert_not @waybill.valid?
    assert @waybill.errors.added? :doc_no, :too_long, count: 10
  end

  test ':doc_no should be unique' do
    dup = @waybill.dup
    dup.doc_no.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :doc_no, :taken
  end

  test ':initial_date should be present' do
    @waybill.initial_date = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :initial_date, :blank
  end

  test ':final_date should be present' do
    @waybill.final_date = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :final_date, :blank
  end

  test ':vehicle should be present' do
    @waybill.vehicle = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :vehicle, :required
  end

  test ':initial_mileage should be present' do
    @waybill.initial_mileage = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :initial_mileage, :blank
  end

  test ':final_mileage should be present' do
    @waybill.final_mileage = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :final_mileage, :blank
  end

  test ':initial_fuel should be present' do
    @waybill.initial_fuel = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :initial_fuel, :blank
  end

  test ':final_fuel should be present' do
    @waybill.final_fuel = nil
    assert_not @waybill.valid?
    assert @waybill.errors.added? :final_fuel, :blank
  end

  # Fixtures

  test 'should be two records' do
    assert_equal 2, Waybill.count
  end

  test 'should find records' do
    h = { september_2016_one: '1549537',
          september_2016_two: '1549538' }
    h.each do |key, value|
      record = waybills(key)
      assert_equal value, record.doc_no
    end
  end
end
