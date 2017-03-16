require 'minitest/autorun'

require_relative '../../lib/helpers/string_helper'

class StringHelperTest < Minitest::Test

  DEFAULT_BASE_STRING = 'x'
  BASE_STRING = "not_#{DEFAULT_BASE_STRING}"

  def test_string_of_length

    method = :string_of_length

    # Good data.
    {
        [0] => DEFAULT_BASE_STRING * 0,
        [1] => DEFAULT_BASE_STRING * 1,
        [4] => DEFAULT_BASE_STRING * 4,
        [0, BASE_STRING] => '',
        [1, BASE_STRING] => BASE_STRING[0],
        [BASE_STRING.size * 2 - 1, BASE_STRING] => (BASE_STRING * 2)[0..-2],
    }.each_pair do |args, expected|
      actual = StringHelper.send(method, *args)
      assert_equal(expected, actual, args.inspect)
    end

    # Bad first argument.
    [
        # Not Integer.
        ['1.0', BASE_STRING],
        # Not Pos]
        [-1, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

  end

  def test_string_of_min_length

    method = :string_of_min_length

    # Good data.
    {
        [(0..1), nil] => DEFAULT_BASE_STRING * 0,
        [(1..1), nil] => DEFAULT_BASE_STRING * 1,
        [(4..4), nil] => DEFAULT_BASE_STRING * 4,
        [(0..1), BASE_STRING] => '',
        [(1..1), BASE_STRING] => BASE_STRING[0],
        [((BASE_STRING.size * 2 - 1)..100), BASE_STRING] => (BASE_STRING * 2)[0..-2],
    }.each_pair do |args, expected|
      range, base_string = *args
      actual = StringHelper.send(method, range, base_string)
      assert_equal(expected, actual, args.inspect)
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

  end

  def test_string_of_max_length

    method = :string_of_max_length

    # Good data.
    {
        [(0..0), nil] => DEFAULT_BASE_STRING * 0,
        [(0..1), nil] => DEFAULT_BASE_STRING * 1,
        [(0..4), nil] => DEFAULT_BASE_STRING * 4,
        [(0..0), BASE_STRING] => '',
        [(0..1), BASE_STRING] => BASE_STRING[0],
        [(0..(BASE_STRING.size * 2 - 1)), BASE_STRING] => (BASE_STRING * 2)[0..-2],
    }.each_pair do |args, expected|
      range, base_string = *args
      actual = StringHelper.send(method, range, base_string)
      assert_equal(expected, actual, args.inspect)
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

  end

  def test_string_too_short

    method = :string_too_short

    # Good data.
    {
        [(0..1), nil] => nil,
        [(1..1), nil] => StringHelper.string_of_length(0),
        [(4..4), nil] => StringHelper.string_of_length(3),
        [(0..1), BASE_STRING] => nil,
        [(1..1), BASE_STRING] => '',
        [(2..2), BASE_STRING] => BASE_STRING[0],
        [(BASE_STRING.size * 2 - 1)..(BASE_STRING.size * 2), BASE_STRING] => (BASE_STRING * 2)[0..-3],
    }.each_pair do |args, expected|
      range, base_string = *args
      actual = StringHelper.send(method, range, base_string)
      # Accommodate Minitest, by not asserting equal for nil.
      if expected.nil?
        assert_nil(actual, args.inspect)
      else
        assert_equal(expected, actual, args.inspect)
      end
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

  end

  def test_string_too_long

    method = :string_too_long

    # Good data.
    {
        [(0..0), nil] => StringHelper.string_of_length(1),
        [(0..1), nil] => StringHelper.string_of_length(2),
        [(0..3), nil] => StringHelper.string_of_length(4),
        [(0..0), BASE_STRING] => StringHelper.string_of_length(1, BASE_STRING),
        [(0..1), BASE_STRING] => StringHelper.string_of_length(2, BASE_STRING),
        [0..(BASE_STRING.size * 2 - 1), BASE_STRING] => (BASE_STRING * 2)[0..-1],
    }.each_pair do |args, expected|
      range, base_string = *args
      actual = StringHelper.send(method, range, base_string)
      assert_equal(expected, actual, args.inspect)
    end

    # Bad first argument.
    [
        # Not Range.
        [0, BASE_STRING],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0],
    ].each do |args|
      assert_raises(ParamContractError) do
        StringHelper.send(method, *args)
      end
    end

  end

end