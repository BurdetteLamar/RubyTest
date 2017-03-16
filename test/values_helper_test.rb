require 'minitest/autorun'

require_relative '../lib/values_helper'

class ValuesHelperTest < Minitest::Test

  def test_string_of_length

    default_base_string = 'x'
    other_base_string = 'xyzzy'

    # Good data.
    {
        [0] => default_base_string * 0,
        [1] => default_base_string * 1,
        [4] => default_base_string * 4,
        [0, other_base_string] => '',
        [1, other_base_string] => 'x',
        [8, other_base_string] => 'xyzzyxyz',
    }.each_pair do |args, expected|
      actual = ValuesHelper.string_of_length(*args)
      assert_equal(expected, actual, args.inspect)
    end

    # Bad first argument.
    [
        # Not Integer.
        ['1.0'],
        # Not Pos]
        [-1],
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.string_of_length(*args)
      end
    end

    # Bad second argument.
    [
        # Not String.
        [0, 0]
    ].each do |args|
      assert_raises(ParamContractError) do
        ValuesHelper.string_of_length(*args)
      end
    end

  end



end