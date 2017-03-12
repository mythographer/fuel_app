require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  def setup
    @abc = subjects :abc
  end

  test 'responds to name_en, name_ua' do
    %i(name_en name_ua).each do |attr|
      assert_respond_to @abc, attr
    end
  end

  test 'should be valid' do
    assert @abc.valid?
  end

  test ':name_en should be present' do
    @abc.name_en = nil
    assert_not @abc.valid?
    assert @abc.errors.added? :name_en, :blank
  end

  test ':name_en should not be loo long' do
    @abc.name_en = 'a' * 256
    assert_not @abc.valid?
    assert @abc.errors.added? :name_en, :too_long, count: 255
  end

  test 'should reject duplicate :name_en' do
    dup = @abc.dup
    dup.name_en.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_en, :taken
  end

  test ':name_ua should be present' do
    @abc.name_ua = nil
    assert_not @abc.valid?
    assert @abc.errors.added? :name_ua, :blank
  end

  test ':name_ua should not be loo long' do
    @abc.name_ua = 'a' * 256
    assert_not @abc.valid?
    assert @abc.errors.added? :name_ua, :too_long, count: 255
  end

  test 'should reject duplicate :name_ua' do
    dup = @abc.dup
    dup.name_ua.mb_chars.upcase!
    assert_not dup.valid?
    assert dup.errors.added? :name_ua, :taken
  end
end
