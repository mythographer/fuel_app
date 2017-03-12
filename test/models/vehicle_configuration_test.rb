require 'test_helper'

class VehicleConfigurationTest < ActiveSupport::TestCase
  def setup
    @configuration = vehicle_configurations :ford_focus_sedan_comfort
  end

  test 'responds to vehicle_bodywork, vehicle_trim_level, engine,
        gearbox, awd, fuel_capacity' do
    %i(vehicle_bodywork vehicle_trim_level engine gearbox awd
       fuel_capacity).each do |attr|
      assert_respond_to @configuration, attr
    end
  end

  test 'should be valid' do
    assert @configuration.valid?
  end

  test ':vehicle_bodywork should be present' do
    @configuration.vehicle_bodywork = nil
    assert_not @configuration.valid?
    assert @configuration.errors.added? :vehicle_bodywork, :required
    assert @configuration.errors.added? :vehicle_bodywork, :blank
  end

  test ':vehicle_trim_level should be present' do
    @configuration.vehicle_trim_level = nil
    assert_not @configuration.valid?
    assert @configuration.errors.added? :vehicle_trim_level, :required
    assert @configuration.errors.added? :vehicle_trim_level, :blank
  end

  test ':engine should be present' do
    @configuration.engine = nil
    assert_not @configuration.valid?
    assert @configuration.errors.added? :engine, :required
    assert @configuration.errors.added? :engine, :blank
  end

  test ':gearbox should be present' do
    @configuration.gearbox = nil
    assert_not @configuration.valid?
    assert @configuration.errors.added? :gearbox, :required
    assert @configuration.errors.added? :gearbox, :blank
  end

  test ':awd should be present' do
    @configuration.awd = nil
    assert_not @configuration.valid?
    assert @configuration.errors.added? :awd, :inclusion
    assert_includes @configuration.errors[:awd],
      'is not included in the list'
  end

  test ':fuel_capacity should be greater than 0' do
    @configuration.fuel_capacity = 0
    assert_not @configuration.valid?
    assert @configuration.errors.added? :fuel_capacity, :greater_than, count: 0
  end
end
