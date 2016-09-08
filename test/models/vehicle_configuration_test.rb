require 'test_helper'

class VehicleConfigurationTest < ActiveSupport::TestCase
  def setup
    @configuration = vehicle_configurations :ford_focus_sedan_comfort
  end

  test 'responds to vehicle_bodywork, vehicle_trim_level, engine,
        gearbox, awd, fuel_capacity' do
    [:vehicle_bodywork, :vehicle_trim_level, :engine, :gearbox, 
     :awd, :fuel_capacity].each do |attr|
      assert_respond_to @configuration, attr
    end
  end

  test 'should be valid' do
    assert @configuration.valid?
  end

  test 'bodywork should be present' do
    @configuration.vehicle_bodywork = nil
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:vehicle_bodywork], "must exist"
    assert_includes @configuration.errors[:vehicle_bodywork], "can't be blank"
  end

  test 'trim level should be present' do
    @configuration.vehicle_trim_level = nil
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:vehicle_trim_level], "must exist"
    assert_includes @configuration.errors[:vehicle_trim_level], "can't be blank"
  end

  test 'engine should be present' do
    @configuration.engine = nil
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:engine], "must exist"
    assert_includes @configuration.errors[:engine], "can't be blank"
  end

  test 'gearbox should be present' do
    @configuration.gearbox = nil
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:gearbox], "must exist"
    assert_includes @configuration.errors[:gearbox], "can't be blank"
  end

  test 'AWD should be present' do
    @configuration.awd = nil
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:awd],
      'is not included in the list'
  end

  test 'fuel capacity should be greater than 0' do
    @configuration.fuel_capacity = 0
    assert_not @configuration.valid?
    assert_includes @configuration.errors[:fuel_capacity],
      'must be greater than 0'
  end
end
