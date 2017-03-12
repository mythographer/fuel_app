require 'test_helper'

class VehicleGroupTest < ActiveSupport::TestCase
  def setup
    @group_a = vehicle_groups :A
  end

  test 'responds to name, descr' do
    %i(name descr).each do |attr|
      assert_respond_to @group_a, attr
    end
  end

  test 'should be valid' do
    assert @group_a.valid?
  end

  test ':name should be present' do
    @group_a.name = nil
    assert_not @group_a.valid?
    assert @group_a.errors.added? :name, :blank
  end

  test ':name should not be too long' do
    @group_a.name = 'a' * 2
    assert_not @group_a.valid?
    assert @group_a.errors.added? :name, :wrong_length, count: 1
  end

  test 'should reject duplicate :name' do
    @other_group = @group_a.dup
    @other_group.name.upcase!
    assert_not @other_group.valid?
    assert @other_group.errors.added? :name, :taken
  end

  test ':description should not be too long' do
    @group_a.descr = 'a' * 51
    assert_not @group_a.valid?
    assert @group_a.errors.added? :descr, :too_long, count: 50
  end
end
