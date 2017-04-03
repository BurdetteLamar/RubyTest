require_relative '../common_requires'

require_relative '../../lib/helpers/set_helper'

# Class to test class +SetHelper+.
class SetHelperTest < MiniTest::Test

  def test_compare

    # Contract violation for expected set arg.
    assert_raises ParamContractError do
      SetHelper.compare(nil, {})
    end

    # Contract violation for actual set arg.
    assert_raises ParamContractError do
      SetHelper.compare({}, nil)
    end

    # General case.
    expected_missing = Set.new([:a, :b])
    expected_unexpected = Set.new([:c, :d])
    expected_ok = Set.new([:e, :f])
    # Build the argument sets, expected and actual.
    expected = Set.new
    actual = Set.new
    expected_missing.each do |value|
      expected.add(value)
    end
    expected_unexpected.each do |value|
      actual.add(value)
    end
    expected_ok.each do |value|
      expected.add(value)
      actual.add(value)
    end
    # Call and assert.
    actual = SetHelper.compare(expected, actual)
    # Use fetch, not [], so that key errors would be raised.
    actual_missing = actual.fetch(:missing)
    actual_unexpected = actual.fetch(:unexpected)
    actual_ok = actual.fetch(:ok)
    assert_equal(expected_missing, actual_missing, 'expected only')
    assert_equal(expected_unexpected, actual_unexpected, 'actual only')
    assert_equal(expected_ok, actual_ok, 'same')
  end

end