require 'test_helper'

class EngineTest < ActiveSupport::TestCase
  def setup
    @engine = engines :engine_T1_9
  end

  test 'responds to capacity_l, capacity_cc, fuel_brand, power,
        engine_power' do
    [:capacity_l, :capacity_cc, :fuel_brand, :power,
     :engine_power].each do |attr|
      assert_respond_to @engine, attr
    end
  end

  test 'should be valid' do
    assert @engine.valid?
  end

  test 'capacity_l should be present' do
    @engine.capacity_l = nil
    assert_not @engine.valid?
    assert_includes @engine.errors[:capacity_l], "can't be blank"
  end

  test 'capacity_l should be positive' do
    @engine.capacity_l = 0
    assert_not @engine.valid?
    assert_includes @engine.errors[:capacity_l], 'must be greater than 0.0'
  end

  test 'capacity_cc should be present' do
    @engine.capacity_cc = nil
    assert_not @engine.valid?
    assert_includes @engine.errors[:capacity_cc], "can't be blank"
  end

  test 'capacity_cc should be positive' do
    @engine.capacity_cc = 0
    assert_not @engine.valid?
    assert_includes @engine.errors[:capacity_cc], 'must be greater than 0.0'
  end

  test 'fuel brand should be present' do
    @engine.fuel_brand = nil
    assert_not @engine.valid?
    assert_includes @engine.errors[:fuel_brand], "can't be blank"
  end

  test 'power should be present' do
    @engine.power = nil
    assert_not @engine.valid?
    assert_includes @engine.errors[:power], "can't be blank"
  end

  test 'power should be greater than 0' do
    @engine.power = 0
    assert_not @engine.valid?
    assert_includes @engine.errors[:power], 'must be greater than 0'
  end

  test 'should be unique' do
    engine_dup = @engine.dup
    assert_not engine_dup.valid?
    assert_includes engine_dup.errors[:capacity_cc], 'has already been taken'
  end
end
