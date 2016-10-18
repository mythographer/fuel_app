require 'test_helper'

class FillUpStatusTest < ActiveSupport::TestCase
  def setup
    @new = fill_up_statuses :new
  end

  test 'should respond to name, description' do
    assert_respond_to @new, :name 
    assert_respond_to @new, :description
  end

  # Associations.

  test 'should have zero or more fill-ups' do
    refl = FillUpStatus.reflect_on_association :fill_ups
    assert_not_nil refl
    assert_equal refl.macro, :has_many
    assert_equal refl.options, {}
  end
  
  # Validations.

  test 'should be valid' do
    assert @new.valid?
  end

  test 'status name should be present' do
    @new.name = nil
    assert_not @new.valid?
    assert_includes @new.errors[:name], "can't be blank"
  end

  test 'status name should not be too long' do
    @new.name = 'a' * 31
    assert_not @new.valid?
    assert_includes @new.errors[:name], '30 characters is the maximum allowed'
  end

  test 'status name should be unique' do
    dup = @new.dup
    dup.name.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name], 'has already been taken'
  end

  test 'description should not be too long' do
    @new.description = 'a' * 256
    assert_not @new.valid?
    assert_includes @new.errors[:description],
      '255 characters is the maximum allowed'
  end
end
