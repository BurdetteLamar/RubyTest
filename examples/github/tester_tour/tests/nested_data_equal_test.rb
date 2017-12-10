require_relative '../../api/base_classes/base_class_for_test'

require_relative '../../data/rate_limit'

class NestedDataEqualTest < BaseClassForTest

  def test_nested_data_equal
    prelude do |log, api_client|
      rate_limit_0 = RateLimit.get(api_client)
      rate_limit_1 = RateLimit.deep_clone(rate_limit_0)
      log.section('These are equal') do
        fail unless RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, :rate_limits_equal, rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
      log.section('These are not equal') do
        rate_limit_1.resources.core.limit = RateLimit::Core_.invalid_value_for(:limit)
        fail if RateLimit.equal?(rate_limit_0, rate_limit_1)
        RateLimit.verdict_equal?(log, :rate_limits_not_equal, rate_limit_0, rate_limit_1, 'Using RateLimit.verdict_equal?')
      end
    end
  end

end
