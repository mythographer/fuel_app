require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  def setup
    @abc = subjects :abc
  end

  test 'responds to name_en, name_ua' do
    [:name_en, :name_ua].each do |attr|
      assert_respond_to @abc, attr
    end
  end

  test 'should be valid' do
    assert @abc.valid?
  end

  test 'english name should be present' do
    @abc.name_en = nil
    assert_not @abc.valid?
    assert_includes @abc.errors[:name_en], "can't be blank"
  end

  test 'english name should not be loo long' do
    @abc.name_en = 'a' * 256
    assert_not @abc.valid?
    assert_includes @abc.errors[:name_en],
      'is too long (maximum is 255 characters)'
  end

  test 'english name should be unique' do
    dup = @abc.dup
    dup.name_en.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_en], 'has already been taken'
  end

  test 'ukrainian name should be present' do
    @abc.name_ua = nil
    assert_not @abc.valid?
    assert_includes @abc.errors[:name_ua], "can't be blank"
  end

  test 'ukrainian name should not be loo long' do
    @abc.name_ua = 'a' * 256
    assert_not @abc.valid?
    assert_includes @abc.errors[:name_ua],
      'is too long (maximum is 255 characters)'
  end

  test 'ukrainian name should be unique' do
    dup = @abc.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert_includes dup.errors[:name_ua], 'has already been taken' 
  end
end
