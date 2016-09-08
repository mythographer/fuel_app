require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    @vehicle = vehicles :one
  end

  test 'responds to vin, vehicle_configuration, vehicle_registration,
        vehicle_trademark_color, metallic, fleet, vehicle_status, cost_centre,
        vehicle_inventory' do
    [:vin, :vehicle_configuration, :vehicle_registration,
     :vehicle_trademark_color, :metallic, :fleet, :vehicle_status,
     :cost_centre, :vehicle_inventory].each do |attr|
       assert_respond_to @vehicle, attr
     end
  end

  test 'should be valid' do
    assert @vehicle.valid?
    assert vehicles(:new_car).valid?
  end

  test 'VIN can be nil' do
    @vehicle.vin = nil
    assert @vehicle.valid?
  end

  test 'VIN should be entered in upper case' do
    @vehicle.vin.downcase!
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vin], 'wrong VIN'
  end

  test 'VIN should not be too long' do
    @vehicle.vin = '2FMZA51U0WBD539570000000000'
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vin], 'wrong VIN'
  end

  test 'VIN should be unique' do
    car = @vehicle.dup
    assert_not car.valid?
    assert_includes car.errors[:vin], 'has already been taken'
  end

  test 'configuration should be present' do
    @vehicle.vehicle_configuration = nil
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_configuration], 'must exist'
    assert_includes @vehicle.errors[:vehicle_configuration], "can't be blank"
  end

  test 'trademark color should be present' do
    @vehicle.vehicle_trademark_color = nil
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_trademark_color], 'must exist'
    assert_includes @vehicle.errors[:vehicle_trademark_color], "can't be blank"
  end

  test 'metallic flag value should be present' do
    @vehicle.metallic = nil
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:metallic], 'is not included in the list'
  end

  test 'status should be present' do
    @vehicle.vehicle_status = nil
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_status], 'must exist'
    assert_includes @vehicle.errors[:vehicle_status], "can't be blank"
  end

  test 'registration record should be unique' do
    @vehicle.vehicle_registration = vehicles(:two).vehicle_registration
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_registration], 'has already been taken'
  end

  test 'registration record can be nil' do
    @vehicle.vehicle_registration = nil
    assert @vehicle.valid?
  end

  test 'inventory record should be unique' do
    @vehicle.vehicle_inventory = vehicles(:two).vehicle_inventory
    assert_not @vehicle.valid?
    assert_includes @vehicle.errors[:vehicle_inventory], 'has already been taken'
  end

  test 'inventory record can be nil' do
    @vehicle.vehicle_inventory = nil
    assert @vehicle.valid?
  end
end
