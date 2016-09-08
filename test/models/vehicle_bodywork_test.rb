require 'test_helper'

class VehicleBodyworkTest < ActiveSupport::TestCase
  def setup
    @bw = vehicle_bodyworks :ford_focus_sedan_4doors_4seats_passenger
  end

  test 'responds to vehicle_model, vehicle_mark_body_type, doors_count,
        seating_capacity, vehicle_category' do
    [:vehicle_model, :vehicle_mark_body_type, :doors_count, :seating_capacity,
     :vehicle_category].each do |attr|
      assert_respond_to @bw, attr
    end
  end

  test 'should be valid' do
    assert @bw.valid?
  end

  test 'vehicle model should be present' do
    @bw.vehicle_model = nil
    assert_not @bw.valid?
    assert_includes @bw.errors[:vehicle_model], "can't be blank"
  end

  test 'vehicle mark body type should be present' do
    @bw.vehicle_mark_body_type = nil
    assert_not @bw.valid?
    assert_includes @bw.errors[:vehicle_mark_body_type], "can't be blank"
  end

  test 'doors count should be present' do
    @bw.doors_count = nil
    assert_not @bw.valid?
    assert_includes @bw.errors[:doors_count], "can't be blank"
  end

  test 'doors count should be a positive value' do
    @bw.doors_count = -1
    assert_not @bw.valid?
    assert_includes @bw.errors[:doors_count],
      'must be greater than or equal to 0'
  end

  test 'seating capacity should be present' do
    @bw.seating_capacity = nil
    assert_not @bw.valid?
    assert_includes @bw.errors[:seating_capacity], "can't be blank"
  end

  test 'seating capacity should be a positive value' do
    @bw.seating_capacity = -1
    assert_not @bw.valid?
    assert_includes @bw.errors[:seating_capacity],
      'must be greater than or equal to 0'
  end

  test 'vehicle category should be present' do
    @bw.vehicle_category = nil
    assert_not @bw.valid?
    assert_includes @bw.errors[:vehicle_category], "can't be blank"
  end

  test 'vehicle_model is not duplicated' do
    other_bw = @bw.dup
    assert_not other_bw.valid?
    assert_includes other_bw.errors[:vehicle_model], 'has already been taken'
  end
end
