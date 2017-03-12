require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  def setup
    @vehicle = vehicles :one
  end

  test 'responds to vin, vehicle_configuration, vehicle_registration,
    vehicle_trademark_color, metallic, fleet, vehicle_status, cost_centre,
    vehicle_inventory' do
    %i(vin vehicle_configuration vehicle_registration vehicle_trademark_color
      metallic fleet vehicle_status cost_centre
      vehicle_inventory).each do |attr|
      assert_respond_to @vehicle, attr
    end
  end

  test 'should be valid' do
    assert @vehicle.valid?
    assert vehicles(:new_car).valid?
  end

  test ':vin can be nil' do
    @vehicle.vin = nil
    assert @vehicle.valid?
  end

  test ':vin should be entered in upper case' do
    @vehicle.vin.downcase!
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vin, 'wrong VIN'
  end

  test ':vin should not be too long' do
    @vehicle.vin = @vehicle.vin + '0' * 10
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vin, 'wrong VIN'
  end

  test 'should reject duplicate :vin' do
    car = @vehicle.dup
    assert_not car.valid?
    assert car.errors.added? :vin, 'has already been taken'
  end

  test 'vehicle_configuration should be present' do
    @vehicle.vehicle_configuration = nil
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vehicle_configuration, :required
  end

  test ':vehicle_trademark_color should be present' do
    @vehicle.vehicle_trademark_color = nil
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vehicle_trademark_color, :required
  end

  test ':metallic should be present' do
    @vehicle.metallic = nil
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :metallic, :inclusion
  end

  test ':vehicle_status should be present' do
    @vehicle.vehicle_status = nil
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vehicle_status, :required
  end

  test 'should reject duplicate :vehicle_registration' do
    @vehicle.vehicle_registration = vehicles(:two).vehicle_registration
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vehicle_registration, :taken
  end

  test 'registration record can be nil' do
    @vehicle.vehicle_registration = nil
    assert @vehicle.valid?
  end

  test 'should reject duplicate :vehicle_inventory' do
    @vehicle.vehicle_inventory = vehicles(:two).vehicle_inventory
    assert_not @vehicle.valid?
    assert @vehicle.errors.added? :vehicle_inventory, :taken
  end

  test ':vehicle_inventory record can be nil' do
    @vehicle.vehicle_inventory = nil
    assert @vehicle.valid?
  end
end
