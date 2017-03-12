require 'test_helper'

class FillUpStatusTest < ActiveSupport::TestCase
  def setup
    @new = fill_up_statuses :new
  end

  test 'should respond to name, description' do
    %i(name description).each do |attr|
      assert_respond_to @new, attr
    end
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

  test ':name should be present' do
    @new.name = nil
    assert_not @new.valid?
    assert @new.errors.added? :name, :blank
  end

  test ':name should not be too long' do
    @new.name = 'a' * 31
    assert_not @new.valid?
    assert @new.errors.added? :name, :too_long, count: 30
  end

  test 'should reject duplicate :name' do
    dup = @new.dup
    dup.name.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name, :taken
  end

  test ':description should not be too long' do
    @new.description = 'a' * 256
    assert_not @new.valid?
    assert @new.errors.added? :description, :too_long, count: 255
  end

  # Fixtures

  test 'should be two records' do
    assert_equal 2, FillUpStatus.count
  end

  test 'should find records' do
    h = { new: 'новий' , handled: 'оброблений' }
    h.each do |key, value|
      record = fill_up_statuses(key)
      assert_equal value, record.name
    end
  end
end
