require 'minitest/autorun'

require_relative '../../lib/helpers/string_helper'
require_relative '../../lib/helpers/values_helper'

class ValuesHelperTest < Minitest::Test

  DEFAULT_BASE_STRING = StringHelper::DEFAULT_BASE_STRING
  BASE_STRING = "not_#{DEFAULT_BASE_STRING}"

  def test_integers_in_range

    method = :integers_in_range

    # Good argument.
    [
        (0..0),
        (-1..1),
    ].each do |range|
      expected = {
          :min => range.first,
          :max => range.last,
      }
      actual = ValuesHelper.send(method, range)
      assert_equal(expected, actual, range.inspect)
    end

    # Bad argument.
    [
        # Not Range.
        0,
        # Range min not integer.
        (1.1..2),
        # Range max not integer.
        (0..2.1)
    ].each do |range|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, range)
      end
    end

  end

  def test_integers_not_in_range

    method = :integers_not_in_range

    # Good argument.
    [
        (0..0),
        (-1..1),
    ].each do |range|
      expected = {
          :too_small => range.first - 1,
          :too_large => range.last + 1,
      }
      actual = ValuesHelper.send(method, range)
      assert_equal(expected, actual, range.inspect)
    end

    # Bad argument.
    [
        # Not Range.
        0,
        # Range min not integer.
        (1.1..2),
        # Range max not integer.
        (0..2.1)
    ].each do |range|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, range)
      end
    end

  end

  def test_strings_in_range

    method = :strings_in_range

    # Good data.
    [
        DEFAULT_BASE_STRING,
        BASE_STRING,
    ].each do |base_string|
      [
          (0..0),
          (0..4),
          (4..4),
      ].each do |range|
        args = [range, base_string]
        expected = {
            :min_length => StringHelper.string_of_length(range.first, base_string),
            :max_length => StringHelper.string_of_length(range.last, base_string),
        }
        actual = ValuesHelper.send(method, *args)
        assert_equal(expected, actual, args.inspect)
      end
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, *args)
      end
    end

  end

  def test_strings_not_in_range

    method = :strings_not_in_range

    # Good data.
    [
        DEFAULT_BASE_STRING,
        BASE_STRING,
    ].each do |base_string|
      [
          (1..0),
          (1..4),
          (4..4),
      ].each do |range|
        args = [range, base_string]
        expected = {
            :too_short => StringHelper.string_of_length(range.first-1, base_string),
            :too_long => StringHelper.string_of_length(range.last+1, base_string),
        }
        actual = ValuesHelper.send(method, *args)
        assert_equal(expected, actual, args.inspect)
      end
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
        # Range min not positive.
        (0..1),
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.send(method, *args)
      end
    end

  end

end