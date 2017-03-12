require 'test_helper'

class VehicleBodyworkTest < ActiveSupport::TestCase
  def setup
    @bw = vehicle_bodyworks :ford_focus_sedan_4doors_4seats_passenger
  end

  test 'responds to vehicle_model, vehicle_mark_body_type, doors_count,
        seating_capacity, vehicle_category' do
    %i(vehicle_model vehicle_mark_body_type doors_count seating_capacity
     vehicle_category).each do |attr|
      assert_respond_to @bw, attr
    end
  end

  test 'should be valid' do
    assert @bw.valid?
  end

  test ':vehicle_model should be present' do
    @bw.vehicle_model = nil
    assert_not @bw.valid?
    assert @bw.errors.added? :vehicle_model, :blank
  end

  test ':vehicle_mark_body_type should be present' do
    @bw.vehicle_mark_body_type = nil
    assert_not @bw.valid?
    assert @bw.errors.added? :vehicle_mark_body_type, :blank
  end

  test ':doors_count should be present' do
    @bw.doors_count = nil
    assert_not @bw.valid?
    assert @bw.errors.added? :doors_count, :blank
  end

  test ':doors_count should be a positive value' do
    @bw.doors_count = -1
    assert_not @bw.valid?
    assert @bw.errors.added? :doors_count, :greater_than_or_equal_to, count: 0
  end

  test ':seating_capacity should be present' do
    @bw.seating_capacity = nil
    assert_not @bw.valid?
    assert @bw.errors.added? :seating_capacity, :blank
  end

  test ':seating_capacity should be a positive value' do
    @bw.seating_capacity = -1
    assert_not @bw.valid?
    assert @bw.errors.added? :seating_capacity, :greater_than_or_equal_to, count: 0
  end

  test ':vehicle_category should be present' do
    @bw.vehicle_category = nil
    assert_not @bw.valid?
    assert @bw.errors.added? :vehicle_category, :blank
  end

  test 'should reject duplicate :vehicle_model' do
    other_bw = @bw.dup
    assert_not other_bw.valid?
    assert other_bw.errors.added? :vehicle_model, :taken
  end
end
