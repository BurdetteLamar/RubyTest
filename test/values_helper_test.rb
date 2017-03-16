require 'minitest/autorun'

require_relative '../lib/values_helper'

class ValuesHelperTest < Minitest::Test

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
      actual = ValuesHelper.send(method, *args)
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
      actual = ValuesHelper.send(method, range, base_string)
      assert_equal(expected, actual, args.inspect)
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

end