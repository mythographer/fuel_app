require 'test_helper'

class VehicleInventoryTest < ActiveSupport::TestCase
  def setup
    @vehicle_inventory = vehicle_inventories :one
  end

  test 'responds to vehicle, date_in, date_out' do
    %i(vehicle date_in date_out).each do |attr|
      assert_respond_to @vehicle_inventory, attr
    end
  end

  test 'should be valid' do
    assert @vehicle_inventory.valid?
  end

  test 'vehicle should be present' do
    @vehicle_inventory.vehicle = nil
    assert_not @vehicle_inventory.valid?
    assert_includes @vehicle_inventory.errors[:vehicle], "can't be blank"
  end

  test 'date_in should be present' do
    @vehicle_inventory.date_in = nil
    assert_not @vehicle_inventory.valid?
    assert_includes @vehicle_inventory.errors[:date_in], "can't be blank"
  end

  test 'date_in should be unique per vehicle' do
    dup = @vehicle_inventory.dup
    dup.date_in = @vehicle_inventory.date_in
    assert_not dup.valid?
    assert_includes dup.errors[:date_in], 'has already been taken'
  end

  test 'date_in should not be in the future' do
    @vehicle_inventory.date_in = Date.tomorrow
    assert_not @vehicle_inventory.valid?
    assert_includes @vehicle_inventory.errors[:date_in],
      'is not included in the list'
  end

  test 'date_out should not be in the future' do
    @vehicle_inventory.date_out = Date.tomorrow
    assert_not @vehicle_inventory.valid?
    assert_includes @vehicle_inventory.errors[:date_out],
      'is not included in the list'
  end

  # todo: date_out >= date_in
end
