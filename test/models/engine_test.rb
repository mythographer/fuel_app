require 'test_helper'

class EngineTest < ActiveSupport::TestCase
  def setup
    @engine = engines :engine_T1_9
  end

  test 'responds to capacity_l, capacity_cc, fuel_brand, power,
        engine_power' do
    %i(capacity_l capacity_cc fuel_brand power engine_power).each do |attr|
      assert_respond_to @engine, attr
    end
  end

  test 'should be valid' do
    assert @engine.valid?
  end

  test ':capacity_l should be present' do
    @engine.capacity_l = nil
    assert_not @engine.valid?
    assert @engine.errors.added? :capacity_l, :blank
  end

  test ':capacity_l should be positive' do
    @engine.capacity_l = 0
    assert_not @engine.valid?
    assert @engine.errors.added? :capacity_l, :greater_than, count: 0.0
  end

  test ':capacity_cc should be present' do
    @engine.capacity_cc = nil
    assert_not @engine.valid?
    assert @engine.errors.added? :capacity_cc, :blank
  end

  test ':capacity_cc should be positive' do
    @engine.capacity_cc = 0
    assert_not @engine.valid?
    assert @engine.errors.added? :capacity_cc, :greater_than, count: 0.0
  end

  test ':fuel_brand should be present' do
    @engine.fuel_brand = nil
    assert_not @engine.valid?
    assert @engine.errors.added? :fuel_brand, :required
  end

  test ':power should be present' do
    @engine.power = nil
    assert_not @engine.valid?
    assert @engine.errors.added? :power, :blank
  end

  test ':power should be greater than 0' do
    @engine.power = 0
    assert_not @engine.valid?
    assert @engine.errors.added? :power, :greater_than, count: 0
  end

  test 'should reject duplicate' do
    engine_dup = @engine.dup
    assert_not engine_dup.valid?
    assert engine_dup.errors.added? :capacity_cc, :taken
  end
end
