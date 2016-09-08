require 'test_helper'

class VehicleGroupTest < ActiveSupport::TestCase
  def setup
    @group_a = vehicle_groups :A
  end

  test 'responds to name, descr' do
    [:name, :descr].each do |attr|
      assert_respond_to @group_a, attr
    end
  end

  test 'should be valid' do
    assert @group_a.valid?
  end

  test 'name should be present' do
    @group_a.name = nil
    assert_not @group_a.valid?
    assert_includes @group_a.errors[:name], "can't be blank"
  end

  test 'name should not be too long' do
    @group_a.name = 'a' * 2
    assert_not @group_a.valid?
    assert_includes @group_a.errors[:name],
      'is the wrong length (should be 1 character)'
  end

  test 'name should be unique' do
    @other_group = @group_a.dup
    @other_group.name.upcase!
    assert_not @other_group.valid?
    assert_includes @other_group.errors[:name], 'has already been taken'
  end

  test 'description should not be too long' do
    @group_a.descr = 'a' * 51
    assert_not @group_a.valid?
    assert_includes @group_a.errors[:descr], 'is too long (maximum is 50 characters)'
  end
end
