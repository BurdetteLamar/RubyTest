require_relative '../common_requires'

require_relative '../../lib/helpers/hash_helper'

# Class to test class +HashHelper+.
class HashHelperTest < MiniTest::Test

  def test_compare

    # Contract violation for expected hash arg.
    assert_raises ParamContractError do
      HashHelper.compare(nil, {})
    end

    # Contract violation for actual hash arg.
    assert_raises ParamContractError do
      HashHelper.compare({}, nil)
    end

    # General case.
    expected_missing = {
        :a => 0,
        :b => 1,
    }
    expected_unexpected = {
        :c => 2,
        :d => 3,
    }
    expected_changed = {
        :e => {:expected => 5, :actual => 6},
        :f => {:expected => 6, :actual => 5},
    }
    expected_ok = {
        :g => 7,
        :h => 8,
    }
    # Build the arguments.\\ hashes, expected and actual.
    expected = {}
    actual = {}
    expected_missing.each_pair do |key, value|
      expected[key] = value
    end
    expected_unexpected.each_pair do |key, value|
      actual[key] = value
    end
    expected_ok.each_pair do |key, value|
      expected[key] = value
      actual[key] = value
    end
    expected_changed.each_pair do |key, value|
      expected[key] = value[:expected]
      actual[key] = value[:actual]
    end
    # Call and assert.
    actual = HashHelper.compare(expected, actual)
    # Use fetch, not [], so that key errors would be raised.
    actual_missing = actual.fetch(:missing)
    actual_unexpected = actual.fetch(:unexpected)
    actual_changed = actual.fetch(:changed)
    actual_ok = actual.fetch(:ok)
    assert_equal(expected_missing, actual_missing, 'expected only')
    assert_equal(expected_unexpected, actual_unexpected, 'actual only')
    assert_equal(expected_changed, actual_changed, 'changed')
    assert_equal(expected_ok, actual_ok, 'same')
  end

end